class OrderProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_product, only: %i[show edit update destroy]

  # GET /order_products
  def index
    @order_products = OrderProduct.joins(:order).where(orders: { user_id: current_user.id })
  end

  # GET /order_products/1
  def show
  end

  # GET /order_products/new
  def new
    @order_product = OrderProduct.new
  end

  # GET /order_products/1/edit
  def edit
  end

  # POST /order_products
  def create
    @order_product = OrderProduct.new(order_product_params)

    if @order_product.order.user_id != current_user.id
      redirect_to order_products_path, alert: "Vous ne pouvez pas ajouter un produit à une commande qui ne vous appartient pas."
      return
    end

    respond_to do |format|
      if @order_product.save
        format.html { redirect_to @order_product, notice: "Produit ajouté à la commande avec succès." }
        format.json { render :show, status: :created, location: @order_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_products/1
  def update
    respond_to do |format|
      if @order_product.update(order_product_params)
        format.html { redirect_to @order_product, notice: "Produit de la commande mis à jour avec succès." }
        format.json { render :show, status: :ok, location: @order_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_products/1
  def destroy
    @order_product.destroy
    respond_to do |format|
      format.html { redirect_to order_products_path, notice: "Produit supprimé de la commande avec succès." }
      format.json { head :no_content }
    end
  end

  private

    def set_order_product
      @order_product = OrderProduct.joins(:order).where(orders: { user_id: current_user.id }).find(params[:id])
    end

    def order_product_params
      params.require(:order_product).permit(:order_id, :product_id, :quantity, :price_at_purchase)
    end
end
