class AddColumnsToBooking < ActiveRecord::Migration
  def change
    change_table :bookings, bulk: true do |t|
      t.column :freight_type, :string
      t.column :cbm, :integer
      t.column :weight, :integer
      t.column :pick_up_date, :date
      t.column :transition_days, :integer
      t.column :cut_off_date, :date      
    end 
  end
end
