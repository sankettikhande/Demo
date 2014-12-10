class ChangeColumnDeliveryDaysToTransitionDays < ActiveRecord::Migration
  def change
    rename_column :freights, :delivery_days, :transition_days
  end
end
