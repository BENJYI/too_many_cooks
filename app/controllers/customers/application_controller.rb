module Customers
  class ApplicationController < ::ApplicationController

    protect_from_forgery with: :exception

    def checkout
      @restaurant = current_order.restaurant
      if current_order.place_order # returns true or false depending on whether it worked or not
        # Delete session
        session.delete :order_id
        render "customers/order_confirmation"
      else
        # TODO // Re-route to customer account management page
        redirect_to @restaurant, notice: "Insufficient funds"
      end
    end

    def example_protected_route
      render plain: "customers/application_controller#example_protected_route is working"
    end

  end
end
