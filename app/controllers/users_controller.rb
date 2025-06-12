class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :profile ]

  def index
    @users = User.all
  end

  def profile
    @orders = current_user.orders.includes(order_products: :product)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      redirect_to root_path, notice: "Inscription réussie ! Un email de bienvenue vous a été envoyé."
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
