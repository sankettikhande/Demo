class BookingPolicy
  attr_reader :user, :booking

  def initialize(user, booking)
    @user = user
    @booking = booking
  end

  def destroy?
    user == booking.buyer && (booking.is_hold? || booking.is_draft?)
  end

  def can_rate?
    user == booking.buyer || user == booking.seller
  end

  def can_update_round_one?
    user == booking.seller
  end

end