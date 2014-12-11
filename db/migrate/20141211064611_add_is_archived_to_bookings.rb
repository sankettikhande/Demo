class AddIsArchivedToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :is_archived, :boolean, default: false
  end
end
