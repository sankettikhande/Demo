class ChangeColumnCutOffDateToDateType < ActiveRecord::Migration
  def change
    change_column :freights, :cut_off_date, :date
  end
end
