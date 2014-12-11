class AddressBooksController < ApplicationController

  def new
    @booking = Booking.find(params[:booking_id])
    @supplier_address = AddressBook.new(address_type: 'supplier')
    @consignees_address = AddressBook.new(address_type: 'consignees')
  end

  def create
    permited_attributes = AddressBook.column_names
    supplier_address = current_user.address_books.create(params.require(:supplier).permit(permited_attributes))
    consignees_address = current_user.address_books.create(params.require(:consignees).permit(permited_attributes))
    booking = Booking.find(params[:booking_id])
    booking.supplier_id = supplier_address.id
    booking.consignees_id = consignees_address.id
    booking.save
    redirect_to payment_bookings_path
  end

end
