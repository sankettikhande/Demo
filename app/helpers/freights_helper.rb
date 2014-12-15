module FreightsHelper

def delivery_date(freight_rate)
  freight_rate.cut_off_date + freight_rate.transition_days.to_i.days 


end

end
