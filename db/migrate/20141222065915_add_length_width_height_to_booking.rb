class AddLengthWidthHeightToBooking < ActiveRecord::Migration
  def change
    change_table :bookings, bulk: true do |t|
      t.column :length , :integer
      t.column :width, :integer
      t.column :height, :integer
      t.column :quantity, :integer
    end
  end
end
