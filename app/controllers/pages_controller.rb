class PagesController < ApplicationController
  def index
    @hide_cart = true
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
