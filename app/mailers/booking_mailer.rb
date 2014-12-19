class BookingMailer < ActionMailer::Base
  default from: "from@example.com"

  def draft_booking(user)
    mail(to: user.email, subject: "Draft Booking")
  end

  def active_booking(user)
    mail(to: user.email, subject: "Active Booking")
  end

  def booking_confirmation(user)
    mail(to: user.email, subject: "Your booking has been conformed")
  end

  def booking_rejection(user)
    mail(to: user.email, subject: "Your booking has been Rejected!")
  end
end
