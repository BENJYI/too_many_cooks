module Managers
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    def dashboard
      @orders = current_manager.restaurant.orders
      render "managers/dashboard"
    end

    def example_protected_route
      render plain: "managers/application_controller#example_protected_route is working"
    end

  end
end
