Rails.application.routes.draw do
  get "/recettes", to: "recipes#index", as: :recipes

  namespace :admin do
    get "products/index"
    get "products/show"
    get "products/new"
    get "products/create"
    get "products/edit"
    get "products/update"
    get "products/destroy"
    get "dashboard/index"
  end
  root "products#index"

  devise_for :users



  resource :cart, only: [ :show ] do
    get "add/:product_id/:quantity", to: "cart_products#add", as: :add_to_cart
    resources :cart_products, only: [ :show, :destroy, :edit, :update ]
  end

  resources :orders, only: [ :new, :create, :index, :show, :destroy ] do
    member do
      get :checkout
      get :invoice
      get :confirmation
    end

    collection do
      get :success
      get :cancel
    end
  end

  resources :order_products
  resources :products

  resources :slider_images


  get "/profil", to: "users#profile", as: :user_profile
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :products
  end
end
