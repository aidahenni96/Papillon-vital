# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    line_items = @order.products.map do |product|
      {
        price_data: {
          currency: 'eur',
          product_data: {
            name: product.name
          },
          unit_amount: (product.price * 100).to_i
        },
        quantity: 1 # Tu peux changer si tu as une quantité
      }
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      success_url: order_url(@order),
      cancel_url: products_url
    )

    redirect_to session.url, allow_other_host: true
  end
end
