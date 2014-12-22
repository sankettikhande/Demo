class Location < ActiveRecord::Base

  #has_many :freight_at_source, class_name: 'Freight', foreign_key: 'source'
  #has_many :freight_at_destination, class_name: 'Freight', foreign_key: 'destination'

  def full_address
    port + '('+ country + ')'
  end

end
