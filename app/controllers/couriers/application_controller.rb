module Couriers
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    def dashboard
      @approved_orders = current_courier.restaurant.orders.approved
      @delivered_orders = current_courier.restaurant.orders.delivered
      render "couriers/dashboard"
    end


    def example_protected_route
      render plain: "couriers/application_controller#example_protected_route is working"
    end

  end
end
