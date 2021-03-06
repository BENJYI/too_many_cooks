Rails.application.routes.draw do

  root to: "pages#index"

  # HACK: Prevent devise sign_up routes for chefs/delivery_me
  [:chefs, :couriers].each do |user_type|
    match "/#{user_type}/sign_up", to: "pages#not_found", via: :all
  end

  # 1. Customers
  devise_for :customers
  authenticate :customer do
    resources :order_items, only: [:create, :update]
    scope :customers do
      get "/" => "customers/application#dashboard", as: :customers_dashboard
      get "example_protected_route" => "customers/application#example_protected_route"
    end
    namespace :customers do
      post "checkout" => "application#checkout"
      post "charge" => "application#charge"
      resources :orders, only: [:index, :edit, :update]
      resources :menu_item_feedbacks, only: [:update]
    end
  end

  # 2. Managers
  devise_for :managers
  authenticate :manager do
    scope :managers  do
      get "/" => "managers/application#dashboard", as: :managers_dashboard
      get "example_protected_route" => "managers/application#example_protected_route"
      resources :chefs do
        post "upvote" => "chefs#upvote", on: :collection
        post "downvote" => "chefs#downvote", on: :collection
      end
      resources :couriers
    end
    namespace :managers do
      resources :orders, only: [:show, :index, :update]
      resources :restaurants, only: [:edit, :update]
    end
  end

  # 3. Chefs
  devise_for :chefs
  authenticate :chef do
    scope :chefs do
      get "/" => "chefs/application#dashboard", as: :chefs_dashboard
      get "example_protected_route" => "chefs/application#example_protected_route"
      resources :menu_items
    end
  end

  # 4: Couriers (Delivery personnel)
  devise_for :couriers
  authenticate :courier do
    scope :couriers do
      get "/" => "couriers/application#dashboard", as: :couriers_dashboard
      get "example_protected_route" => "couriers/application#example_protected_route"
    end

    namespace :couriers do
      resources :orders, only: [:show, :update]
    end
  end

  # 5: All Users
  resources :restaurants, only: [:index, :show]

  # TOO MANY COOKS!
  get "/too_many_cooks" => "pages#too_many_cooks"

end
