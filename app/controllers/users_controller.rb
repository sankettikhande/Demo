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

  def register_supplier_consignees
    address_books = current_user.address_books
    @suppliers = address_books.supplier_address
    @consignees = address_books.consignees_address
  end

 protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :company_registration_number, :address_line_1, :address_line_2, :address_line_3, :post_code, :city, :state, :country, :phone_number)
  end

end
