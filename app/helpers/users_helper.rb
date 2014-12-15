module UsersHelper

  def company_log(id)
    User.find(id).avatar.url
  end

end
