class UserInformationController < ApplicationController

	before_action :authenticate_user!

	def new
		@user_information = UserInformation.new
		respond_to do |format|
			format.html # new.html.erb
		end
	end

	def create
		@user_information = current_user.build_user_information(user_information_params)
		respond_to do |format|
			if @user_information.save
				format.html { redirect_to edit_user_information_path(@user_information), notice: 'User Information was successfully created.' }
				format.json { render json: @user_information }
			else
				redirect_to '/verify_company_information'
			end
		end
	end

	def edit
		@user_information  = current_user.user_information
		if @user_information
			respond_to do |format|
				format.html # new.html.erb
			end
		else
			redirect_to '/verify_company_information'
		end
	end

	def update
		update_user_information = current_user.user_information.update_attributes!(user_information_params)
		respond_to do |format|
			if update_user_information
				format.html { redirect_to '/company_information'}
			else
				format.json { render json: @user_information.errors, status: :unprocessable_entity }
			end
		end
	end

	private

	def user_information_params
		params.require(:user_information).permit(:cin,:company_name,:company_registration_number,:company_pan_number,:scan_registration_copy,:scan_pan_copy,:company_class,:authorised_capital,:paid_up_capital,:date_of_incoporation,:is_listed,:date_of_last_balance_sheet,:company_status,:category)
	end

end
