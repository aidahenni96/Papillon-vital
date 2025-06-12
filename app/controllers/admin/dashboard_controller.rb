class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @products = Product.all
    @products_count = Product.count
    @users_count = User.count
    @total_stock = Product.sum(:stock)
    @average_price = Product.average(:price)&.round(2)
    @total_revenue = Order.sum(:total_price)
    @orders_by_day = Order.group_by_day(:created_at).count
    @recent_orders = Order.order(created_at: :desc).limit(5)
  end

  private

  def require_admin
    redirect_to root_path, alert: "Accès réservé à l'administration" unless current_user.admin?
  end
end
