class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_order

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :address, :email, :password, :password_confirmation)
    end
  end

  def current_order
    if session[:order_id].present? && (order=Order.find_by(id: session[:order_id]))
      order
    else
      Order.new customer: current_customer
    end
  end
end
