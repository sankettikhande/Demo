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

  def negotiation_round_one
    @bookings = current_user.seller_bookings.pending_bookings
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
    @seller_bookings = current_user.seller_bookings.active_bookings
  end

  def update_booking_status
    seller_booking = current_user.seller_bookings.find(params[:booking_id])
    seller_booking.update_attributes!(:aasm_state => params[:order_status],:remark=>params[:remark])
    respond_to do |format|
      format.html {redirect_to  seller_confirmation_order_bookings_path}
    end
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
    @minimum_freight_price = @freight_rates.map(&:price).min
    @fastest_delivery = @freight_rates.map(&:transition_days).min
    @average_price = (@freight_rates.map(&:price).inject(:+))/@freight_rates.count
    @draft_booking.update(min_rate: @minimum_freight_price, avg_rate: @average_price, min_transition_days: @fastest_delivery )
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
  
  def update_cart_details_section
    render :partial => "bookings/cart_details"
  end

end
