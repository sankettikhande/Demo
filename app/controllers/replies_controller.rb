class RepliesController < ActionController::Base
  respond_to :html, :xml, :json
  def new
    @complaint = Complaint.find(params[:complaint_id])
    @reply = @complaint.replies.new
    #respond_with(@reply)
  end

  def create
    complaint = Complaint.find(params[:complaint_id])
    reply = complaint.replies.build(reply_params)
    reply.save
    redirect_to complaints_path
  end

  private

  def reply_params
      params.require(:reply).permit(:note,:replier_id,:replier_type)
  end

end