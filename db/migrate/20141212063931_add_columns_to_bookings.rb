class AddColumnsToBookings < ActiveRecord::Migration
  def change
    change_table :bookings, bulk: true do |t|
      t.column :spot_rate, :integer
      t.column :min_rate, :integer
      t.column :avg_rate, :integer
      t.column :round_one_rate, :integer
    end
  end
end
