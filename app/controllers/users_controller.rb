class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end
  def profile
    @orders = current_user.orders.includes(order_products: :product)
  end
end
