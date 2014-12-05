class CreateAddressBooks < ActiveRecord::Migration
  def change
    create_table :address_books do |t|
      t.string :company_name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :address
      t.integer :post_code
      t.string :city
      t.string :cargo_description
      t.timestamps
    end
  end
end
