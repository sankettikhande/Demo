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


  def reviews
    @seller = User.find(params[:seller_id])
    @freight_id = params[:freight_id]
    @rates = @seller.rates.where(created_at: 6.months.ago..Time.now)
    respond_to do |format|
      format.js { render layout: false}
    end
  end

  def reviews_by_stars
    @seller = User.find(params[:seller_id])
    @freight_id = params[:freight_id]
    @star = params[:star].to_i
    @valid_star = (1..5).to_a.include?(@star)
    stars = @valid_star ? [@star] : (1..5).to_a
    @rates = @seller.rates.where(created_at: 6.months.ago..Time.now, score: stars)
    respond_to do |format|
      format.js { render layout: false}
    end
  end

  private
  def rate_params
    params.require(:rate).permit(:score, :suggestion, :feedback, :is_courteous, :on_time_delivery)
  end

end
