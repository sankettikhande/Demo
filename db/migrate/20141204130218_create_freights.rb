class CreateFreights < ActiveRecord::Migration
  def change
    create_table :freights do |t|
      t.string :source
      t.string :destination
      t.integer :cbm
      t.integer :min_weight
      t.integer :max_weight
      t.integer :price
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
