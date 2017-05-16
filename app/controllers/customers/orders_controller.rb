module Customers
  class OrdersController < ApplicationController

    def index
      @orders = current_customer.orders.delivered
    end

    def edit
      @order = Order.find(params[:id])
    end

    def update
      @order = Order.find(params[:id])
      if @order.update(order_params)
        redirect_to edit_customers_order_path(@order), notice: "Feedback sent!"
      else
        redirect_to edit_customers_order_path(@order), notice: "Error!"
      end
    end

    private
    def order_params
      params.require(:order).permit(:comment)
    end

  end
end