class RatesController < ApplicationController

  before_action :authenticate_user!

  def new
    @rate = Rate.new
    @booking = Booking.find(params[:booking_id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @booking = Booking.find(params[:booking_id])

    authorize @booking, :can_rate?
    rateable_type, rateable_id = current_user.id == @booking.buyer_id ? ["seller", @booking.seller_id] : ["buyer", @booking.buyer_id]

    @rate = Rate.create(rate_params.merge(booking_id: @booking.id, rater_id: current_user.id, rateable_type: rateable_type ,rateable_id: rateable_id))
    respond_to do |format|
      format.js
    end
  end

  private
  def rate_params
    params.require(:rate).permit(:score, :suggestion, :feedback, :is_courteous, :on_time_delivery)
  end

end
