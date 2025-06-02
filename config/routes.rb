Rails.application.routes.draw do
  root "products#index"

  devise_for :users

  

  resource :cart, only: [:show] do
    get 'add/:product_id/:quantity', to: 'cart_products#add', as: :add_to_cart
    resources :cart_products, only: [:show, :destroy, :edit, :update]
  end

  resources :orders, only: [:new, :create, :index, :show, :destroy] do
    member do
      get :checkout
      get :invoice
    end

    collection do
      get :success
      get :cancel
    end
  end

  resources :order_products
  resources :products

  get "/profil", to: "users#profile", as: :user_profile
  get "up" => "rails/health#show", as: :rails_health_check
end
