Rails.application.routes.draw do

  root to: "pages#index"

  # 1. Users
  devise_for :users
  authenticate :user do
    get "/users/example_protected_route" => "users/application#example_protected_route"
  end

  # 2. Managers
  devise_for :managers
  authenticate :manager do
    scope :managers  do
      get "/" => "managers/application#dashboard"
      get "example_protected_route" => "managers/application#example_protected_route"
      resources :restaurants, :controller => "managers/restaurants", only: [:index, :edit, :update]
      resources :chefs
    end
  end

  # 3. Chefs
  devise_for :chefs
  authenticate :chef do
    scope :chefs do
      get "/" => "chefs/application#dashboard"
      get "/chefs/example_protected_route" => "chefs/application#example_protected_route"
      resources :menu_items
    end
  end

end
