class UsersController < ApplicationController

  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to '/myaccount'
    else
      render 'edit'
    end

  end

 protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :company_registration_number, :address_line_1, :address_line_2, :address_line_3, :post_code, :city, :state, :country, :phone_number)
  end

end
