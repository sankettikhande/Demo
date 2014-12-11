class BookingPolicy
  attr_reader :user, :booking

  def initialize(user, booking)
    @user = user
    @booking = booking
  end

  def destroy?
    user == booking.buyer && (booking.is_hold? || booking.is_draft?)
  end

end