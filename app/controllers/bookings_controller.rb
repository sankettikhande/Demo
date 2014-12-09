class BookingsController < ApplicationController

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
    @bookings = current_user.buyer_bookings.draft_bookings
  end

  def archived_bookings
    @bookings = current_user.buyer_bookings.archived_bookings
  end

  def get_quote
    @draft_booking = Booking.find params[:id]
    @freight_rates = Freight.search conditions: {source: @draft_booking.source, destination: @draft_booking.destination}
  end
  
  def payment
  end
  
end
