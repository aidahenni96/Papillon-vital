class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || current_user.create_cart!
    @cart_products = @cart.cart_products.includes(:product)
    @total_price = @cart_products.sum do |ci|
      (ci.product.price || 0) * (ci.quantity || 1)
    end
  end

  def add_to_cart
    @cart = current_user.cart || current_user.create_cart!

    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

  
    cart_product = @cart.cart_products.find_by(product_id: product.id)

    if cart_product
      
      cart_product.quantity += quantity
      cart_product.save
    else

      @cart.cart_products.create(product: product, quantity: quantity)
    end

    redirect_to cart_path, notice: "#{quantity} x #{product.name} ajouté(s) au panier."
  end
end
