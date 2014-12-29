class CreateUserInformations < ActiveRecord::Migration
  def change
    create_table :user_informations do |t|
			t.integer  :user_id
			t.string   :cin,:limit=>21
			t.string   :company_name
			t.string   :company_registration_number
			t.string   :company_pan_number
			t.string   :scan_registration_copy
			t.string   :scan_pan_copy
			t.string   :company_class
			t.integer  :authorised_capital
			t.integer  :paid_up_capital
			t.date     :date_of_incoporation
			t.boolean  :is_listed, :default=> true
			t.date     :date_of_last_balance_sheet
			t.string   :company_status
			t.string   :category
			t.timestamps
    end
  end
end
