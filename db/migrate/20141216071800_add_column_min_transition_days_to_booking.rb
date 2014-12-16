class AddColumnMinTransitionDaysToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :min_transition_days, :integer
  end
end
