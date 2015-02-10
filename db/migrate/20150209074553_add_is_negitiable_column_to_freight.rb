class AddIsNegitiableColumnToFreight < ActiveRecord::Migration
  def change
    add_column :freights, :is_negotiable, :boolean, :default => false
  end
end
