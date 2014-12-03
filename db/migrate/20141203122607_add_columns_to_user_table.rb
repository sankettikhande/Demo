class AddColumnsToUserTable < ActiveRecord::Migration

  def self.up
      add_column :users, :first_name, :string
      add_column :users, :last_name, :string
      add_column :users, :company_name, :string
      add_column :users, :company_registration_number, :string
      add_column :users, :address_line_1, :string
      add_column :users, :address_line_2, :string
      add_column :users, :address_line_3, :string
      add_column :users, :post_code, :integer
      add_column :users, :city, :string
      add_column :users, :state, :string
      add_column :users, :country, :string
      add_column :users, :phone_number, :string
      add_column :users, :preferred_currency, :string
   end

   def self.down
      remove_column :users, :first_name
      remove_column :users, :last_name
      remove_column :users, :company_name
      remove_column :users, :company_registration_number
      remove_column :users, :address_line_1
      remove_column :users, :address_line_2
      remove_column :users, :address_line_3
      remove_column :users, :post_code
      remove_column :users, :city
      remove_column :users, :state
      remove_column :users, :country
      remove_column :users, :phone_number
      remove_column :users, :preferred_currency
   end

end