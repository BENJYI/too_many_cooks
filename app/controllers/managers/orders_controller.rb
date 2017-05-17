module Managers
  class OrdersController < ApplicationController
    def show
      @order = current_manager.restaurant.orders.find(params[:id])
    end

    def index
      @orders = current_manager.restaurant.orders
    end

    def update
      order = current_manager.restaurant.orders.find(params[:id])
      if order.update(order_params)
        redirect_to managers_orders_path, notice: "Order status updated!"
      else
        redirect_to managers_orders_path, notice: "Order update failed."
      end
    end

    private

    def order_params
      params.require(:order).permit(:status)
    end

  end
end