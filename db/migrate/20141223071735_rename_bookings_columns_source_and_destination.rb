class RenameBookingsColumnsSourceAndDestination < ActiveRecord::Migration
  def change
    rename_column :bookings, :source, :source_id
    rename_column :bookings, :destination, :destination_id
  end
end
