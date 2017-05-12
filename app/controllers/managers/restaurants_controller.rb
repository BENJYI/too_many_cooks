module Managers
  class RestaurantsController < ApplicationController
    before_action :set_restaurant

    # GET /restaurants (it only displays the mangers ONE restauarnt)
    def index
    end

    # GET /restaurants/1/edit
    def edit
    end

    # PATCH/PUT /restaurants/1
    def update
      if @restaurant.update(restaurant_params)
        redirect_to manager_restaurants_path, notice: 'Restaurant was successfully updated.'
      else
        render :edit
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_restaurant
        @restaurant = current_manager.restaurant
      end
  end
end