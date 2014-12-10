class BookingsController < ApplicationController
  before_action :authenticate_user!, only: :draft_bookings

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
    @bookings = current_user.buyer_bookings.archived_bookings
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
  
  def payment
  end

  def archive
    booking = Booking.find(params[:id])
    booking.update(aasm_state: 'archived')

    redirect_to draft_bookings_bookings_path
  end
  
end
