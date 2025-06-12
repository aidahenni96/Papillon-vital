class OrdersController < ApplicationController
  before_action :authenticate_user!


class OrdersController < ApplicationController
  def new
    @order = Order.new
  end
end

  def index
    @orders = current_user.orders.includes(:products)
    @orders = current_user.orders.order(created_at: :desc)
    @orders_en_cours = current_user.orders.where(status: 'en cours').order(created_at: :desc)
    @orders_passees = current_user.orders.where.not(status: 'en cours').order(created_at: :desc)
  end

  def total_price
    products.sum(:price)
  end


  def show
    @order = current_user.orders.find(params[:id])
  end

  def invoice
    @order = current_user.orders.find(params[:id])
    OrderMailer.confirmation_email(@order).deliver_later
  end

  def destroy
    @order = current_user.orders.find(params[:id])
    @order.order_products.destroy_all
    @order.destroy
    redirect_to orders_path, notice: "Commande supprimée avec succès."
  end

  def create
    cart = current_user.cart
    if cart.nil? || cart.cart_products.empty?
      redirect_to cart_path, alert: "Votre panier est vide."
      return
    end

    order = current_user.orders.create!(
      total_price: cart.cart_products.sum { |cp| cp.product.price * cp.quantity },
      status: 0 # par exemple : en attente
    )

    cart.cart_products.each do |cp|
      order.order_products.create!(
        product: cp.product,
        quantity: cp.quantity,
        price_at_purchase: cp.product.price
      )
    end

    # Vider le panier (optionnel, sinon après le paiement)
    cart.cart_products.destroy_all

    # Rediriger vers la page Stripe de paiement
    redirect_to checkout_order_path(order)
  end

  def checkout
    order = Order.find(params[:id])

    session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: order.order_products.map do |op|
        {
          price_data: {
            currency: "eur",
            unit_amount: ((op.price_at_purchase * 1.2) * 100).to_i,
            product_data: {
              name: "#{op.product.name} (TTC)"
            }
          },
          quantity: op.quantity
        }
      end,
      mode: "payment",
      success_url: orders_url, # à personnaliser
      cancel_url: cart_url
    )

    redirect_to session.url, allow_other_host: true
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    payment_intent = Stripe::PaymentIntent.retrieve(session.payment_intent)

    # Optionnel : tu peux stocker le payment_intent.id dans l’ordre
    order = current_user.orders.order(created_at: :desc).first
    order.update(status: "paid", stripe_payment_id: payment_intent.id)

    # Envoi de l'email de confirmation
    OrderMailer.confirmation_email(order).deliver_later
    UserMailer.order_notification(order).deliver_later

    redirect_to cart_path(status: "paid")
  end

  def confirmation
    @order = Order.find(params[:id])
  end
end
