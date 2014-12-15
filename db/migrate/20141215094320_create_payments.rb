class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :buyer_id
      t.string :payment_mode
      t.string :status
      t.integer :amount_paid
      t.string :currency
      t.string :payment_gateway_response
      t.timestamps
    end
  end
end
