class FreightsController < ApplicationController

  def search
    session['search'] = params[:search].first if params[:search].present?
    @freight_rates = Freight.search conditions: {source: session['search']['source'], destination: session['search']['destination']}
    respond_to do |format|
      if current_user
        id = Booking.create(
          buyer_id: current_user.id, 
          source: session['search']['source'], 
          destination: session['search']['destination'], 
          aasm_state: 'draft',
          cbm: session['search']['cbm'],
          weight: session['search']['weight'],
          pick_up_date: session['search']['date'],
          freight_type: session['search']['freight_type']).id
        
        format.html { redirect_to get_quote_bookings_path(id:id)}
      else
          format.html { render :template => "freights/guest_user_sign_up"}
      end
    end
  end

  def import
    Freight.imports(params[:file])
    redirect_to root_path, notice: "Freights are imported!"
  end

end
