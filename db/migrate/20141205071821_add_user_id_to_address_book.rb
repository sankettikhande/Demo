class AddUserIdToAddressBook < ActiveRecord::Migration
  def change
    add_column :address_books, :user_id, :integer
  end
end
