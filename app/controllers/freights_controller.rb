class FreightsController < ApplicationController

  before_action :authenticate_user!, except: :search
  
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
    session[:bookind_ids] = []
    session[:search] = params[:search] if params[:search].present?
    search_parameter = session[:search].first
    @freight_rates = Freight.search conditions: {source: search_parameter[:source], destination: search_parameter[:destination]}
    respond_to do |format |
      if current_user
        (session[:search] || []).each do |search_freight|
          session[:bookind_ids] << Booking.create(
            buyer_id: current_user.id, 
            source: search_freight['source'], 
            destination: search_freight['destination'], 
            aasm_state: 'draft',
            cbm: search_freight['cbm'],
            weight: search_freight['weight'],
            pick_up_date: search_freight['date'],
            freight_type: search_freight['freight_type']).id
        end
        format.html { redirect_to get_quote_booking_path(id:session[:bookind_ids].first)}
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


