class AddressBook < ActiveRecord::Base
  belongs_to :user
  has_many :supplier_bookings, class_name: "Booking", foreign_key: "supplier_id"  
  has_many :consignees_bookings, class_name: "Booking", foreign_key: "consignees_id"
end
