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
        redirect_to restaurants_path, notice: 'Restaurant was successfully updated.'
      else
        render :edit
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_restaurant
        @restaurant = current_manager.restaurant
      end

      # Only allow a trusted parameter "white list" through.
      def restaurant_params
        params.require(:restaurant).permit(:name, :address, :manager_id)
      end
  end
end