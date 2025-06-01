class CartProductsController < ApplicationController
  before_action :set_cart_product, only: %i[ show edit update destroy ]

 
  def index
    @cart_products = CartProduct.all
  end

  
  def show
  end


  def new
    @cart_product = CartProduct.new
  end

 
  def edit
  end

  def create
    cart = current_user.cart
    product = Product.find(params[:product_id])
  
    if cart.nil?
      redirect_to products_path, alert: "Vous devez être connecté pour ajouter un produit au panier."
      return
    end
  
    if cart.products.include?(product)
      redirect_to cart_path, alert: "Ce produit est déjà dans ton panier."
    else
      cart.cart_products.create!(product: product)
      redirect_to cart_path, notice: "Produit ajouté au panier !"
    end  
  end

  def update
    respond_to do |format|
      if @cart_product.update(cart_product_params)
        format.html { redirect_to @cart_product, notice: "Cart product was successfully updated." }
        format.json { render :show, status: :ok, location: @cart_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    cart_product = CartProduct.find(params[:id])
    cart = cart_product.cart
    cart_product.destroy
  
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.remove(cart_product), # supprime la carte de l’item
          turbo_stream.replace("cart_total", partial: "carts/total", locals: { cart: cart })
        ]
      }
      format.html { redirect_to cart_path, notice: "Produit retiré du panier." }
    end
  end
  

  private
  
    def set_cart_product
      @cart_product = CartProduct.find(params.expect(:id))
    end

  
    def cart_product_params
      params.expect(cart_product: [ :cart_id, :product_id ])
    end
end
