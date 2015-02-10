class FreightsController < ApplicationController

  before_action :authenticate_user!, except: :search
  before_action :access_denied!, except: [:search, :filter_freights], unless: proc { current_user.seller?}

  def index
    @freights = current_user.freights
    respond_to do |format|
      format.html # index.html.erb
      format.json # index.json.jbuilder
    end
  end

  def update
    begin
      freight = Freight.find(params[:id])
      authorize  freight, :can_access_freight?
      freight.update_attributes(freight_params)
    rescue => e
      flash[:notice] = "You Are Not Authorize"
    end
    redirect_to freights_path
  end

  def new
    @freight = Freight.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @freight }
    end
  end

  def edit
    @freight = Freight.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    freight = Freight.find(params[:id])
    authorize  freight, :can_access_freight?
    freight.destroy
    respond_to do |format|
      format.js
    end
  end

  def generate_csv_online
    freights = current_user.freights
    csv_string = Freight.export(freights)
    send_data csv_string,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=Freight.csv"
  end


  def update_freights_price
    if params[:freight_data].present?
     Freight.manipulate_freight_data(params)
    else
     flash[:notice]="Please select the freight"
    end
    respond_to do |format|
      format.html {redirect_to  freights_path}
    end
  end

  def search
    session[:booking_ids] = []
    session[:cart] = {}
    session[:search] = params[:search] if params[:search].present?
    search_parameter = session[:search].first
    respond_to do |format |
      if current_user
        (session[:search] || []).each do |search_freight|
          session[:booking_ids] << Booking.create(
            buyer_id: current_user.id, 
            source_id: search_freight['source_id'], 
            destination_id: search_freight['destination_id'], 
            aasm_state: 'draft',
            length: search_freight['length'],
            height: search_freight['height'],
            width: search_freight['width'],
            weight: search_freight['weight'],
            quantity: search_freight['quantity'],
            pick_up_date: search_freight['date'],
            freight_type: search_freight['freight_type']).id
        end
        format.html { redirect_to get_quote_booking_path(id:session[:booking_ids].first)}
      else
        format.html { render :template => "freights/guest_user_sign_up"}
      end
    end
  end

  def filter_freights
    redirect_to get_quote_booking_path(id: session[:booking_ids].first, shipper_ids: params[:shipper_ids], max_price: params[:max_price], transit_time: params[:transit_time])
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
    params.require(:freight).permit(:source_id, :destination_id, :cbm,:height, :width, :length, :seller_id,:cut_off_date, :freight_type, :transition_days, :min_weight, :max_weight, :price, :start_date, :end_date, :remark,:is_negotiable)
  end


  protected

  def access_denied!
    redirect_to(root_path) and return
  end
end


