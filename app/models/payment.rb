class Payment < ActiveRecord::Base
  
  belongs_to :buyer, class: 'User', foreign_key: 'buyer_id'
  has_many :complaints
  has_many :bookings, through: :booking_payments
  has_many :booking_payments
end
