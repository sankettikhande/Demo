class AddRoundOneEndDateColumnToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :round_one_end_date, :datetime
  end
end
