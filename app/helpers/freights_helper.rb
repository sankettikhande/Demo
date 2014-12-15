module FreightsHelper

  def delivery_date(freight_rate)
    freight_rate.cut_off_date + freight_rate.transition_days.to_i.days 
  end

  def company_logo(freight_rate)
    freight_rate.seller.avatar.url
  end

end
