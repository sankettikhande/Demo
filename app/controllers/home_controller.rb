class HomeController < ApplicationController

  before_action :authenticate_user!
    
  def landing
  end
  
end
