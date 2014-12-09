class AddColumsSourceAndDestination < ActiveRecord::Migration
  def change
    add_column :bookings, :source, :string
    add_column :bookings, :destination, :string
  end
end
