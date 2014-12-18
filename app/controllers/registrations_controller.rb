class RegistrationsController < Devise::RegistrationsController

  def register_guest_user

    if guest_user_params.values.any?{|v| v.blank?}
      render :template => "freights/guest_user_sign_up", locals: { notice: "All fields are required" }
    else
      email = params[:user][:email]
      return render :template => "freights/guest_user_sign_up", locals: { notice: "Email allready taken!" } if User.exists?(email: email)
      user = User.new(guest_user_params.merge({role: :guest, password: email, password_confirmation: email}))
      user.skip_confirmation!
      user.save(validate: false)
      sign_in( user )
      redirect_to search_freights_path
    end

  end

  private

  def guest_user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :phone_number, :email,:calling_code)
  end

end