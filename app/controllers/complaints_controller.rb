class ComplaintsController < ApplicationController
  respond_to :html, :xml, :json
  before_action :authenticate_user!

  def index
    @complaints = Complaint.all
    @complaint = Complaint.new
    respond_to do |format|
      format.html
    end
  end

  def new
    @complaint = Complaint.new
  end

  def show
    @complaint = Complaint.find(params[:id])

  end

  def create
    @complaint = Complaint.new(complaint_params)

    respond_to do |format|
      if @complaint.save
        format.html { redirect_to complaints_path, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @complaint }
      else
        format.html { render :new }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end

  private


  def complaint_params
    params.require(:complaint).permit(:payment_id, :note)
  end



end