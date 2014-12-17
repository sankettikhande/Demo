class AddCargoDescriptionFromBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :cargo_description, :string
  end
end
