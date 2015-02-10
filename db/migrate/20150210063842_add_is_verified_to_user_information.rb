class AddIsVerifiedToUserInformation < ActiveRecord::Migration
  def change
    add_column :user_informations, :is_verified, :boolean, default: false
  end
end
