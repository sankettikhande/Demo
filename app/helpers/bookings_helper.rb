module BookingsHelper

  def add_to_cart_session(booking, freight)
    session['cart'] = session['cart'] || {}
    session['cart'].merge!(booking.id => freight.id)
  end

  def is_in_cart?(booking, freight)
    cart = session['cart']
    cart.present? ? cart[booking.id.to_s] == freight.id : false
  end

  def remove_from_cart_session(booking)
    session['cart'] = session['cart'] || {}
    session['cart'].delete(booking.id.to_s)

  end

end
