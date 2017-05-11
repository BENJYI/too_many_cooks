Rails.application.routes.draw do

  root to: "pages#index"

  devise_for :users

  devise_for :managers

  devise_for :chefs

end
