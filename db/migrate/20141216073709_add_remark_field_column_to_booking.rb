class AddRemarkFieldColumnToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :remark, :string, :limit => 2000
  end
end
