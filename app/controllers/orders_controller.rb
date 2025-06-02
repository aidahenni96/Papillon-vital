class OrdersController < ApplicationController
  before_action :authenticate_user!


class OrdersController < ApplicationController
  def new
    @order = Order.new
  end
end

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def invoice
    @order = current_user.orders.find(params[:id])
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
      payment_method_types: ['card'],
      line_items: order.order_products.map do |op|
        {
          price_data: {
            currency: 'eur',
            unit_amount: (op.price_at_purchase * 100).to_i,
            product_data: {
              name: op.product.name
            }
          },
          quantity: op.quantity
        }
      end,
      mode: 'payment',
      success_url: orders_url, # à personnaliser
      cancel_url: cart_url
    )

    redirect_to session.url, allow_other_host: true
  end
end