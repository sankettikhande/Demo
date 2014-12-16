class CreateBookingPayments < ActiveRecord::Migration
  def change
    create_table :booking_payments do |t|
      t.integer :booking_id
      t.integer :payment_id
      t.timestamps
    end
  end
end
