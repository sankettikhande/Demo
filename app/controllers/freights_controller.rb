class FreightsController < ApplicationController

  def search
    session['search'] = params[:search].first if params[:search].present?
    @freight_rates = Freight.search conditions: {source: session['search']['source'], destination: session['search']['destination']}
    respond_to do |format|
      if current_user
        booking = Booking.create(buyer_id: current_user.id, source: session['search']['source'], destination: session['search']['destination'], aasm_state: 'draft')
        format.html { redirect_to get_quote_booking_path(booking)}
      else
          format.html { render :template => "freights/guest_user_sign_up"}
      end
    end
  end

end

