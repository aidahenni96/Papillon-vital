class CartProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_product, only: %i[show edit update destroy]

  # Méthode pour récupérer ou créer le panier de l'utilisateur courant
  def current_cart
    current_user.cart || current_user.create_cart
  end

  # Liste les produits du panier
  def index
    @cart_products = current_cart.cart_products.includes(:product)
  end

  # Affiche le contenu du panier avec calculs
  def show
    @cart_products = current_cart.cart_products.includes(:product)

    if @cart_products.empty?
      redirect_to products_path, alert: "Votre panier est vide."
      return
    end

    @subtotal = @cart_products.sum { |cp| cp.quantity * cp.product.price }
    @tva_rate = 0.20
    @tva_amount = (@subtotal * @tva_rate).round(2)
    @shipping_fee = calculate_shipping_fee(@subtotal)
    @total_ttc = (@subtotal + @tva_amount + @shipping_fee).round(2)
  end

  # Ajoute un produit au panier
  def add
    @product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    cart_product = current_cart.cart_products.find_by(product: @product)

    if cart_product
      cart_product.quantity += quantity
    else
      cart_product = current_cart.cart_products.build(product: @product, quantity: quantity)
    end

    if cart_product.save
      redirect_to cart_path, notice: "Produit ajouté au panier."
    else
      redirect_to products_path, alert: "Erreur lors de l'ajout au panier."
    end
  end

  # Formulaire pour admin
  def new
    @cart_product = CartProduct.new
  end

  # Formulaire pour admin
  def edit; end

  # Création (via bouton "ajouter au panier")
  def create
    cart = current_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    cart_product = cart.cart_products.find_by(product_id: product.id)

    if cart_product
      cart_product.quantity += quantity
      cart_product.save!
      notice_message = "Quantité mise à jour dans le panier."
    else
      cart.cart_products.create!(product: product, quantity: quantity)
      notice_message = "Produit ajouté au panier !"
    end

    redirect_to cart_path, notice: notice_message
  end

  # Mise à jour de la quantité
  def update
    if @cart_product.update(cart_product_params)
      redirect_to cart_path, notice: "Quantité mise à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Suppression d’un produit du panier
  def destroy
    begin
      @cart_product = current_cart.cart_products.find(params[:id])
      cart = @cart_product.cart
      @cart_product.destroy

      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: [
            turbo_stream.remove(@cart_product),
            turbo_stream.replace("cart_total", partial: "carts/total", locals: { cart: cart })
          ]
        }
        format.html { redirect_to cart_path, notice: "Produit retiré du panier." }
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to cart_path, alert: "Produit non trouvé dans le panier."
    end
  end

  private

  # Recherche sécurisée dans le panier courant
  def set_cart_product
    @cart_product = current_cart.cart_products.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_path(current_cart), alert: "Produit introuvable dans votre panier."
  end

  # Sécurisation des paramètres : admin vs utilisateur
  def cart_product_params
    if current_user.admin?
      params.require(:cart_product).permit(:cart_id, :product_id, :quantity)
    else
      {
        cart_id: @cart_product.cart_id,
        product_id: @cart_product.product_id,
        quantity: params.require(:cart_product).permit(:quantity)[:quantity]
      }
    end
  end

  def calculate_shipping_fee(subtotal)
    subtotal < 50 ? 5.0 : 0.0
  end
end