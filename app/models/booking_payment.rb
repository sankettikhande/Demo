class BookingPayment < ActiveRecord::Base

  belongs_to :payment
  belongs_to :booking
end
