class ChangeColumnFreights < ActiveRecord::Migration
  def change
  	change_column :freights, :price, :float
  	change_column :freights, :transition_days, :integer
  end
end
