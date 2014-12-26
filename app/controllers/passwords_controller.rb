class PasswordsController < Devise::PasswordsController

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      respond_to do |format|
        format.html { redirect_to after_sending_reset_password_instructions_path_for(resource_name) }
        format.js { render :js => "$('#forgot-link-sent').html('Password Reset link has been sent to registered email.').addClass('alert alert-info');"}
      end
    else
      respond_to do |format|
        format.html
        format.js { render :js => "$('#forgot-link-sent').html('Email Not registered with Blue Compass.').addClass('alert alert-info');"}
      end
    end
  end

end