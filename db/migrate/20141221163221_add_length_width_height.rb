class AddLengthWidthHeight < ActiveRecord::Migration
  def change
    change_table :freights, bulk: true do |t|
      t.column :length , :integer
      t.column :width, :integer
      t.column :height, :integer
      t.column :remark, :string
    end
  end
end
