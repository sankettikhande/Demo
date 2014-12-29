class UserInformation < ActiveRecord::Base	
	mount_uploader :scan_registration_copy,  AvatarUploader
	mount_uploader :scan_pan_copy, AvatarUploader
	validates  :cin,:company_name,:company_registration_number ,:company_pan_number,:scan_registration_copy,:scan_pan_copy,:company_class,:authorised_capital,:paid_up_capital,:date_of_incoporation,:date_of_last_balance_sheet,:company_status,:category,:presence => true 
	belongs_to :user 
	validates  :is_listed, inclusion: { in: [true, false]}
end
