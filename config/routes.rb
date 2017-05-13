Rails.application.routes.draw do

  resources :order_items
  root to: "pages#index"

  # 1. Customers
  devise_for :customers
  authenticate :customer do
    get "/customers/example_protected_route" => "customers/application#example_protected_route"
  end

  # 2. Managers
  devise_for :managers
  authenticate :manager do
    scope :managers  do
      get "/" => "managers/application#dashboard"
      get "example_protected_route" => "managers/application#example_protected_route"
      resources :restaurants, as: :manager_restaurants, :controller => "managers/restaurants", only: [:index, :edit, :update]
      resources :chefs
    end
  end

  # 3. Chefs
  devise_for :chefs
  authenticate :chef do
    scope :chefs do
      get "/" => "chefs/application#dashboard"
      get "example_protected_route" => "chefs/application#example_protected_route"
      resources :menu_items
    end
  end

  # 4: All Users
  resources :restaurants, only: [:index, :show]
  resources :order_items, only: [:create, :update, :destroy]

end
