class SessionsController < Devise::SessionsController

  def new
    @show_popup = true
    super
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user 
      if user.confirmed?
        self.resource = warden.authenticate!(scope: resource_name, recall: "sessions#failure")
        set_flash_message(:notice, :signed_in) if is_navigational_format?
        sign_in(resource_name, resource)
        respond_to do |format |
          format.html { redirect_to after_sign_in_path_for(resource) }
          format.js { render :js => "window.location.href='#{after_sign_in_path_for(resource)}'" }
        end
      else
        respond_to do |format|
          format.js { render :js => "$('.login-form .alert-danger').html('Please Verify your email').show();" }
        end
      end

    else
      respond_to do |format|
        format.js { render :js => "$('.login-form .alert-danger').html('This email is not found in Blue Compass please register.').show();" }
      end
    end
  end

  def failure
    respond_to do |format |
      format.html { super }
      format.js
    end
  end
end