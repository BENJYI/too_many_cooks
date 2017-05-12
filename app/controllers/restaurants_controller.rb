class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end
end
