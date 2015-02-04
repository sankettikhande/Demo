class UsersController < ApplicationController

  before_action :authenticate_user!, except: :thank_you

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

  def update_user_information
    user = current_user if current_user.seller?
      if params[:user_information].present?
        user.update_attributes!(:first_name => params[:first_name],:last_name=>params[:last_name], :company_name=>params[:comp_name], :company_registration_number=>params[:comp_reg],:address_line_1=>params[:add1],:address_line_2=> params[:add2],:address_line_3=>params[:add3],:post_code=>params[:post_code],:preferred_currency=>params[:currency])
      else
        user.update_attribute!(:email=> params[:email])
      end
    user.save
    respond_to do |format| 
      format.js
    end
  end

  def destroy_user
    user = current_user if current_user.seller?    
    user.destroy if user
    respond_to do |format|
      format.js
    end

  end

  def register_supplier_consignee
    address_books = current_user.address_books
    @suppliers = address_books.supplier_address
    @consignees = address_books.consignee_address
    respond_to do |format |
        format.html 
    end
  end

  def privacy

  end

  def delete_user_account
    if params[:user].present? && current_user.validate_user(params[:user][:email], params[:user][:password])
       redirect_to root_path if current_user.update(is_active: false)
    end    
  end

  def thank_you
    if current_user
      redirect_to root_path
    end
  end

 protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :company_registration_number, :address_line_1, :address_line_2, :address_line_3, :post_code, :city, :state, :country, :phone_number, :calling_code,:preferred_currency, :avatar)
  end

end
