class PaymentsController < ApplicationController

  before_filter :authenticate_user!, :redirect_if_cart_empty
  before_filter :should_be_verified_user, only: [:processing_payment]

  def payment_options

  end

  def processing_payment
    cart = session['cart']
    cart.each do |key, value|
      booking = Booking.find(key)
      freight = Freight.find(value)
      #booking.update(aasm_state: 'active', price: freight.price)
    end  
    #session.delete('cart')
  end

  protected

  def redirect_if_cart_empty
    redirect_to(root_path) and return if session[:cart].nil?
  end

  def should_be_verified_user
    redirect_to "/verify_company_information" if !current_user.user_information || !current_user.user_information.is_verified?
  end

end
