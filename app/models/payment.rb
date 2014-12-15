class Payment < ActiveRecord::Base
  
  belongs_to :booking
  belongs_to :buyer, class: 'User', foreign_key: 'buyer_id' 
  belongs_to :seller, class: 'User', foreign_key: 'sller_id'

end
