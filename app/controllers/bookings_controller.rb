class BookingsController < ApplicationController

  include BookingsHelper

  before_action :authenticate_user!, except: :get_quote

  def index

  end

  def new
  end

  def edit
  end

  def update
  end

  def create
    
  end

  def destroy
  end

  def show

  end

  def active_bookings
    @bookings = current_user.buyer_bookings.active_bookings
  end

  def bookings_on_hold
    @bookings = current_user.buyer_bookings.bookings_on_hold
  end

  def draft_bookings
    @draft_bookings = current_user.buyer_bookings.draft_bookings
  end

  def archived_bookings
    @archived_bookings = current_user.buyer_bookings.archived_bookings
  end

  def get_quote
    @draft_booking = Booking.find params[:id]
    @freight_rates = Freight.search(conditions: 
                                      {
                                        source: @draft_booking.source, 
                                        destination: @draft_booking.destination, 
                                        cut_off_date: @draft_booking.pick_up_date, 
                                        freight_type: @draft_booking.freight_type 
                                      },
                                    with: 
                                      {
                                        cbm: 0..@draft_booking.cbm, 
                                        min_weight: 0..@draft_booking.weight, 
                                        max_weight: @draft_booking.weight..10**30
                                      }
                                    ) #I've opted for very large windows of number, but essentially this ensures the given integer is equal to or larger than the min_weight and less than or equal to the max_weight.
  end
  
  def add_to_cart
    booking = Booking.find(params[:id])
    freight = Freight.find(params[:freight_id])
    add_to_cart_session(booking, freight)
    booking.update(seller_id: freight.seller_id, cut_off_date: freight.cut_off_date, transition_days: freight.transition_days, spot_rate: freight.price)
    render nothing: true
  end

  def remove_from_cart
    booking = Booking.find(params[:id])
    freight = Freight.find(params[:freight_id])
    remove_from_cart_session(booking)
    render nothing: true
  end

  def payment
  end

  def booking_summary
    @cart = session['cart'] || {}
  end

  def destroy
    booking = Booking.find(params[:id])
    authorize  booking, :destroy?
    booking.destroy

    redirect_to draft_bookings_bookings_path
  end
  
end
