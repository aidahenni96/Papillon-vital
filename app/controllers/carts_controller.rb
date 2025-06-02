class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || current_user.create_cart!
    @cart_products = @cart.cart_products.includes(:product)
    @total_price = @cart_products.sum do |ci|
      (ci.product.price || 0) * (ci.quantity || 1)
    end

  end
end