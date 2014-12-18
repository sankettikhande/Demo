class AddCallingCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :calling_code, :integer
  end
end
