class AddUserIdToFreightTable < ActiveRecord::Migration
  def change
    add_column :freights, :seller_id, :integer
  end
end
