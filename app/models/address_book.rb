class AddressBook < ActiveRecord::Base


  validates :company_name, :first_name,:last_name, :email, :phone_number, :address, :post_code, :city, :cargo_description, :user_id, :address_type, :presence => true

  belongs_to :user
  has_many :supplier_bookings, class_name: "Booking", foreign_key: "supplier_id"  
  has_many :consignee_bookings, class_name: "Booking", foreign_key: "consignee_id"

  scope :supplier_address, -> { where(address_type: 'supplier')}
  scope :consignee_address, -> { where(address_type: 'consignee')}
end
