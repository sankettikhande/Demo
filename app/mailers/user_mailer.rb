class UserMailer < ActionMailer::Base
  default from: "from@bluecompass.com"

  def send_password_to_guest_user(email_id)
      @user  = User.where(:email=>email_id).first
      @email_id = email_id
      mail(to: @email_id, subject: 'Your Blue compass Password')
    end
end
