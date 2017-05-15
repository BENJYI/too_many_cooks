class PagesController < ApplicationController
  def index
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
