class HomeController < ApplicationController
    
  def landing
    session['search'] = {} if session['search'].nil?  
    if current_user && current_user.seller?   
      redirect_to controller: 'bookings', action: 'pending'
    else
     render template: 'home/buyer_landing' 
    end
  end
  
end
