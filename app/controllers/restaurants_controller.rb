class RestaurantsController < ApplicationController
  # GET /restaurants
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  def show
    @restaurant = Restaurant.find(params[:id])

    unless current_order.restaurant == @restaurant
      session.delete :order_id
    end
  end
end
