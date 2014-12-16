class PaymentsController < ApplicationController

  def payment_processing
    cart = session['cart']
    cart.each do |key, value|
      booking = Booking.find(key)
      freight = Freight.find(value)
      booking.update(aasm_state: 'active', price: freight.price)
    end  
    session.delete('cart')
  end

end
