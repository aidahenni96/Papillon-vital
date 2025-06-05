class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_cart

  def current_cart
    # Trouve ou crée un panier lié à la session
    if session[:cart_id]
      @current_cart ||= Cart.find_by(id: session[:cart_id])
      # Si le panier n'existe plus en base, on le recrée
      unless @current_cart
        session[:cart_id] = nil
        current_cart
      end
    else
      cart = Cart.create
      session[:cart_id] = cart.id
      @current_cart = cart
    end
  end
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:pseudo, :first_name, :last_name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
