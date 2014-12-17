class PaymentsController < ApplicationController

  before_filter :authenticate_user!, :redirect_if_cart_empty

  def payment_options

  end

  def processing_payment
    cart = session['cart']
    cart.each do |key, value|
      booking = Booking.find(key)
      freight = Freight.find(value)
      booking.update(aasm_state: 'active', price: freight.price)
    end  
    session.delete('cart')
  end

  protected

  def redirect_if_cart_empty
    redirect_to(root_path) and return if session[:cart].nil?
  end

end
