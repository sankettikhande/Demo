class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.integer  "payment_id", limit: nil, precision: 38
      t.string   "note"
      t.string   "status"
      t.integer  "seller_id"
      t.integer  "buyer_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
