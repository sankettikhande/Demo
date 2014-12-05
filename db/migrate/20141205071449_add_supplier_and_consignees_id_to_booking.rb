class AddSupplierAndConsigneesIdToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :supplier_id, :integer
    add_column :bookings, :consignees_id, :integer
  end
end
