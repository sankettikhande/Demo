class FreightsController < ApplicationController

  layout 'application'


  def index
    @freights = current_user.freights
    respond_to do |format|
      format.html # index.html.erb
      format.json # index.json.jbuilder
    end
  end

  def new
    @freight = Freight.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @freight }
    end
  end

  def search
    session[:search] = params[:search].first if params[:search].present?
    search_parameter = session[:search]
    @freight_rates = Freight.search conditions: {source: search_parameter[:source], destination: search_parameter[:destination]}
    respond_to do |format |
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

  def create
    @freight = Freight.new(freight_params)
    respond_to do |format|
      if @freight.save
        format.html { redirect_to freights_path, notice: 'Freight was successfully created.' }
        format.json { render json: @freight }
      else
        format.html { render :new }
        format.json { render json: @freight.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def freight_params
    params.require(:freight).permit(:source, :destination, :cbm, :seller_id, :freight_type, :cut_off_date, :transition_days, :min_weight, :max_weight, :price, :start_date, :end_date)
  end

end

end
