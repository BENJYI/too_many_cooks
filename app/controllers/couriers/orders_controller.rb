module Couriers
  class OrdersController < ApplicationController

    before_action :set_order

    def show
    end

    def update
      if @order.update(order_params)
        redirect_to couriers_dashboard_path, notice: "Order status updated!"
      else
        redirect_to couriers_dashboard_path, notice: "Order update failed."
      end
    end

    private
    def order_params
      params.require(:order).permit(:status)
    end

    def set_order
      @order = current_courier.restaurant.orders.find(params[:id])
    end

  end
end