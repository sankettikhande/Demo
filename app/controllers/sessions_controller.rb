class SessionsController < Devise::SessionsController

  def new
    @show_popup = true
    super
  end

  def create
    self.resource = warden.authenticate!(scope: resource_name, recall: "sessions#failure")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_to do |format |
      format.html { redirect_to after_sign_in_path_for(resource) }
      format.js { render :js => "window.location.href='#{after_sign_in_path_for(resource)}'" }
    end
  end

  def failure
    respond_to do |format |
      format.html { super }
      format.js
    end
  end
end