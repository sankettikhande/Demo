class PaymentsController < ApplicationController

  before_filter :authenticate_user!, :redirect_if_cart_empty
  before_filter :should_be_verified_user, only: [:processing_payment]

  def payment_options

  end

  def processing_payment
    cart = session['cart'] || []
    price_list = []
    cart.each {|key, value| price_list << Freight.find(value).price}
    payment = Payment.create(buyer_id: current_user.id,  payment_mode: 'bank_transfer', amount_paid: price_list.inject(:+), currency: "rupees", payment_gateway_response: "success")
    cart.each do |key, value|
      booking = Booking.find(key)
      freight = Freight.find(value)
      if booking.booking_payments.create(payment_id: payment.id)
        booking.update(aasm_state: 'active', price: freight.price)
      end  
    end  
    session.delete('cart')
  end

  protected

  def redirect_if_cart_empty
    redirect_to(root_path) and return if session[:cart].nil?
  end

  def should_be_verified_user
    cart = session['cart'] || []
    if !current_user.user_information || !current_user.user_information.is_verified?
      (cart || []).each do |key, value|
        booking = Booking.find(key)
        freight = Freight.find(value)
        booking.move_to_document_pending!
      end
      session.delete('cart')
      redirect_to "/verify_company_information"
    end
  end

end
