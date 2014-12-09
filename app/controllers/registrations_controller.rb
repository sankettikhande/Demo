class RegistrationsController < Devise::RegistrationsController

  def register_guest_user
    email = params[:user][:email]
    user_exists = User.exists?(email: email)

    if user_exists
      redirect_to get_quotes_freights_path, notice: "Email allready taken!"
    else
      user = User.new(guest_user_params.merge({role: :guest, password: email, password_confirmation: email}))
      user.skip_confirmation!
      user.save!
      sign_in( user )
      redirect_to search_freights_path
    end

  end

  private

  def guest_user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :phone_number, :email)
  end

end