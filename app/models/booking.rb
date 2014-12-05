class Booking < ActiveRecord::Base
  belongs_to :supplier, class_name: "AddressBook", foreign_key: "supplier_id"
  belongs_to :consignees, class_name: "AddressBook", foreign_key: "consignees_id"
end
