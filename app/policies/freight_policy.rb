class FreightPolicy
  attr_reader :user, :freight

  def initialize(user, freight)
    @user = user
    @freight = freight
  end

  def can_access_freight?
	user == freight.seller
  end

end


