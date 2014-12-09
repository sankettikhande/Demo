class FreightsController < ApplicationController

  layout 'application'

  def search
    session[:search] = params[:search].first if params[:search].present?
    search_parameter = session[:search]
    @freight_rates = Freight.search conditions: {source: search_parameter[:source], destination: search_parameter[:destination]}
    respond_to do |format |
      if current_user
        id = Booking.create(buyer_id: current_user.id, source: search_parameter[:source], destination: search_parameter[:destination], aasm_state: 'draft').id
        format.html { redirect_to get_quote_bookings_path(id:id)}
      else
          format.html { render :template => "freights/guest_user_sign_up"}
      end
    end
  end

end

