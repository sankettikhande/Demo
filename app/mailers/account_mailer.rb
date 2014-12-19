class AccountMailer < Devise::Mailer

  include Devise::Controllers::UrlHelpers

  default template_path: 'devise/mailer'

  def confirmation_instructions(record, token, opts={})
    opts[:subject] = 'Registration Mail'
    super
  end

  def reset_password_instructions(record, token, opts={})
    opts[:subject] = 'Rest Password Instructions'
    super
  end

  def unlock_instructions(record, token, opts={})
    opts[:subject] = 'Unlock Instructions'
    super
  end

end