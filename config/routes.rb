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
    get "/managers/example_protected_route" => "managers/application#example_protected_route"
  end

  # 3. Chefs
  devise_for :chefs
  authenticate :chef do
    get "/chefs/example_protected_route" => "chefs/application#example_protected_route"
  end

end
