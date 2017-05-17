module Managers
  class OrdersController < ApplicationController
    def show
      @order = current_manager.restaurant.orders.find(params[:id])
    end

    def index
      @orders_to_review = current_manager.restaurant.orders.where(status: :delivered)
      @orders_already_reviewed = current_manager.restaurant.orders.feedback_reviewed
      @other_orders = current_manager.restaurant.orders.where(status: [:pending, :approved])
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