class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    permitted_parameters = [:first_name, :last_name, :company_name, :company_registration_number, :address_line_1, :address_line_2, :address_line_3, :post_code, :city, :state, :country, :phone_number, :preferred_currency]
    devise_parameter_sanitizer.for(:sign_up) << permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << permitted_parameters
  end
end
