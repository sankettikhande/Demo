class RegistrationsController < Devise::RegistrationsController

  def register_guest_user
    if guest_user_params.values.any?{|v| v.blank?}
      respond_to do |format|
        format.js { render :js => "$('.signup_form').html('All fields are required').show();" }
      end
    elsif User.exists?(email: params[:user][:email])
      respond_to do |format|
        format.js { render :js => "$('.signup_form').html('Email Allready Exist Please login !').show();" }
      end      
    else  
      email = params[:user][:email]      
      user = User.new(guest_user_params.merge({role: :guest, password: email, password_confirmation: email}))
      user.skip_confirmation!
      create_user = user.save(validate: false)
      sign_in( user )
      if create_user
        flash[:notice] = "Account successfully created passward sent to your email"
        UserMailer.send_password_to_guest_user(email).deliver
        respond_to do |format|
          format.js { render :js => "window.location.href='#{session[:user_return_to]}'" }
        end
      end
    end
  end

  private

  def guest_user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :phone_number, :email,:calling_code)
  end


  protected
    def after_inactive_sign_up_path_for(resource)
      thank_you_url
    end

end