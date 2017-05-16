module Customers
  class OrdersController < ApplicationController

    def index
      @orders = current_customer.orders
    end

    def show
      @order = Order.find(params[:id])
    end

    private
    def order_params
      params.require(:order).permit(:status)
    end

  end
end