class HomeController < ApplicationController
    
  def landing
    session['search'] = {} if session['search'].nil?
     
  end
  
end
