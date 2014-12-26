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

  def get_freight_forwarders
    @sellers = User.where(id: @freight_rates.map(&:seller_id))
  end

  def get_freight_quote(booking)
    beginning, ending = Time.utc(1970), Time.utc(2030)
    @freight_rates = Freight.search(conditions: 
                                      {
                                        source_id: booking.source_id, 
                                        destination_id: booking.destination_id, 
                                        freight_type: booking.freight_type 
                                      },
                                    with: 
                                      {
                                        length: booking.length..10**5,
                                        width: booking.width..10**5,
                                        height: booking.height..10**5, 
                                        min_weight: 0..booking.weight, 
                                        max_weight: booking.weight..10**7,
                                        start_date: beginning..booking.pick_up_date,
                                        end_date: booking.pick_up_date..ending
                                      },
                                    order: 'price asc'  
                                    ).map #I've opted for very large windows of number, but essentially this ensures the given integer is equal to or larger than the min_weight and less than or equal to the max_weight.    
  end

end
