class AddColumnsFreightTypeAndCutOffDateAndDeliveryDays < ActiveRecord::Migration
  def change
    add_column :freights, :freight_type, :string
    add_column :freights, :cut_off_date, :string
    add_column :freights, :delivery_days, :string
  end
end
