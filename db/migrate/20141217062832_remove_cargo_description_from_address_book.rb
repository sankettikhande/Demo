class RemoveCargoDescriptionFromAddressBook < ActiveRecord::Migration
  def change
    remove_column :address_books, :cargo_description
  end
end
