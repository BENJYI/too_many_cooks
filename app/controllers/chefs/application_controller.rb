module Chefs
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    def example_protected_route
      render plain: "chefs/application_controller#example_protected_route is working"
    end

  end
end
