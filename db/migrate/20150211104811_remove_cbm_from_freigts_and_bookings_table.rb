class RemoveCbmFromFreigtsAndBookingsTable < ActiveRecord::Migration
  def change
    remove_column :freights, :cbm
    remove_column :bookings, :cbm
  end
end
