class AddColumnAddressTypeToAddressBook < ActiveRecord::Migration
  def change
    add_column :address_books, :address_type, :string
  end
end
