class BookingMailer < ActionMailer::Base
  default from: "from@example.com"

  def seller_active_booking(booking)
    @booking = booking
    mail(to: @booking.seller.email, subject: "Seller Active booking")
  end

  def buyer_active_booking(booking)
    @booking = booking
    mail(to: @booking.buyer.email, subject: "Buyer Active booking")
  end

  def seller_booking_rejection(booking)
    @booking = booking
    mail(to: @booking.seller.email, subject: "You have rejected booking")
  end

  def buyer_booking_rejection(booking)
    @booking = booking
    mail(to: @booking.buyer.email, subject: "Your booking has been rejected")
  end

  def seller_booking_confirmation(booking)
    @booking = booking
    mail(to: @booking.seller.email, subject: "You confirmed booking")
  end

  def buyer_booking_confirmation(booking)
    @booking = booking
    mail(to: @booking.buyer.email, subject: "Your booking has been confirmed")
  end

  def seller_booking_cancellation(booking)
    @booking = booking
    mail(to: @booking.seller.email, subject: "Booking Cancelled")
  end

  def buyer_booking_cancellation(booking)
    @booking = booking
    mail(to: @booking.buyer.email, subject: "Booking Cancelled")
  end

 end
