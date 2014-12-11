class ChangeColumnConsigneesToConsignee < ActiveRecord::Migration
  def change
    rename_column :bookings, :consignees_id, :consignee_id
  end
end
