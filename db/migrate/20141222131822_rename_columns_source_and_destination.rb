class RenameColumnsSourceAndDestination < ActiveRecord::Migration

  def change
    rename_column :freights, :source, :source_id
    rename_column :freights, :destination, :destination_id
  end

end
