class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!
  before_action :check_admin!

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: "✅ Produit créé avec succès."
    else
      flash.now[:alert] = "❌ Erreur lors de la création."
      render :new
    end
  end

  def edit; end

  def update
    if params[:product][:remove_image] == "1"
      @product.image.purge
    end

    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "✅ Produit mis à jour."
    else
      flash.now[:alert] = "❌ Erreur lors de la mise à jour."
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, notice: "🗑️ Produit supprimé avec succès."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :image)
  end

  def check_admin!
    unless current_user.admin?
      redirect_to root_path, alert: "Accès réservé aux administrateurs."
    end
  end
end
