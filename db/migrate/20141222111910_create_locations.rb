class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :port
      t.string :state
      t.string :country
      t.timestamps
    end
  end
end
