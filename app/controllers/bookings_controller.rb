class BookingsController < ApplicationController

  include BookingsHelper

  before_action :authenticate_user!

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

  def show

  end

  def active_bookings
    @active_bookings = current_user.buyer_bookings.where(aasm_state: ['active', 'confirmed'])
  end

  def bookings_on_hold
    @bookings_on_hold = current_user.buyer_bookings.on_hold
  end

  def draft_bookings
    @draft_bookings = current_user.buyer_bookings.draft
  end

  def negotiation_round_one
    @bookings = current_user.seller_bookings.pending_negotiation
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookings }
    end
  end

  def round_one_price_update
    booking_details_hash = params[:round_one_rate_details] if params[:round_one_rate_details].present?
    if booking_details_hash
        booking_details_hash.each do |key, value|
        booking = Booking.find(key)
        authorize  booking, :can_update_round_one?
        booking.update_attribute(:round_one_rate, value)
      end
      respond_to do |format|
        format.html {redirect_to  negotiation_round_one_bookings_path}
      end
    end
  end

  def seller_confirmation_order
    @seller_bookings = current_user.seller_bookings.pending_confirmations
  end

  def update_booking_status
    if current_user.seller?
      booking = current_user.seller_bookings.find(params[:booking_id])
      booking.update_attributes!(:aasm_state => params[:order_status],:remark=>params[:remark])
    elsif current_user.buyer?
      booking = current_user.buyer_bookings.find(params[:booking_id])
      booking.update_attributes!(:aasm_state => params[:order_status])
    end
    render nothing: true

  end

  def sellers_confirmed_bookings
    @seller_confirmed_bookings = current_user.seller_bookings.confirmed
  end

  def archived_bookings
    @archived_bookings = current_user.buyer_bookings.archived
  end

  def get_quote
    @draft_booking = Booking.find params[:id]
    session[:booking_ids] = session[:booking_ids] || [@draft_booking.id]
    beginning, ending = Time.utc(1970), Time.utc(2030)
    @freight_rates = Freight.search(conditions: 
                                      {
                                        source: @draft_booking.source, 
                                        destination: @draft_booking.destination, 
                                        freight_type: @draft_booking.freight_type 
                                      },
                                    with: 
                                      {
                                        length: @draft_booking.length..10**10,
                                        width: @draft_booking.width..10**10,
                                        height: @draft_booking.height..10**10, 
                                        min_weight: 0..@draft_booking.weight, 
                                        max_weight: @draft_booking.weight..10**30,
                                        start_date: beginning..@draft_booking.pick_up_date,
                                        end_date: @draft_booking.pick_up_date..ending
                                      },
                                    order: 'price asc'  
                                    ).map #I've opted for very large windows of number, but essentially this ensures the given integer is equal to or larger than the min_weight and less than or equal to the max_weight.
    set_search_result_page_variables
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

  def remove_from_search
    booking = Booking.find(params[:id])
    remove_from_cart_session(booking)
    session['booking_ids'].delete(booking.id)
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
    respond_to do |format|
      format.js
    end

  end
  
  def update_cart_details_section
    render :partial => "bookings/cart_details"
  end

  def check_cart_session
    if session[:cart].present?
      render nothing: true  
    else
      render nothing: true, status: 202  
    end  
  end

  protected

  def set_search_result_page_variables
    @min_price_freight = @freight_rates.first.id if @freight_rates.any?
    @fastest_delivery_freight = @freight_rates.map {|f| [f.id, f.transition_days]}.min_by {|t| t[1]}[0]  if @freight_rates.any?
    seller_ids = @freight_rates.map(&:seller_id)
    @ratings = Rate.where(created_at: 6.months.ago..Time.now, rateable_id: seller_ids).group(:rateable_id).count
    @minimum_freight_price = @freight_rates.map(&:price).min
    @fastest_delivery = @freight_rates.map(&:transition_days).min
    @average_price = (@freight_rates.map(&:price).inject(:+))/@freight_rates.count if @freight_rates.any?
    @draft_booking.update(min_rate: @minimum_freight_price, avg_rate: @average_price, min_transition_days: @fastest_delivery )
  end
end
