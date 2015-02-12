class RemoveLocation < ActiveRecord::Migration
  def change
    drop_table :locations if table_exists? :locations
  end
end
