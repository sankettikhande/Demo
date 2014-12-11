class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :score
      t.integer :rater_id
      t.integer :rateable_id
      t.string :rateable_type
      t.integer :booking_id
      t.boolean :on_time_delivery
      t.boolean :is_courteous
      t.text :feedback
      t.text :suggestion

      t.timestamps
    end
  end
end
