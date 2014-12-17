class AddressBooksController < ApplicationController

  before_filter :authenticate_user!
  before_filter :redirect_if_cart_empty

  def new
    @booking = Booking.find(96)
    @supplier_address = AddressBook.new(address_type: 'supplier')
    @consignee_address = AddressBook.new(address_type: 'consignee')
  end

  def create
    permited_attributes = AddressBook.column_names
    supplier_address = current_user.address_books.create!(params.require(:supplier).permit(permited_attributes))
    consignee_address = current_user.address_books.create!(params.require(:consignee).permit(permited_attributes))
    booking = Booking.find(params[:booking_id])
    booking.update(cargo_description: params[:cargo_description])
    booking.supplier_id = supplier_address.id
    booking.consignee_id = consignee_address.id
    booking.save
    render js: "alert('Added')"
  end

  def update
    permited_attributes = AddressBook.column_names   
    booking = Booking.find(params[:booking_id])
    supplier = booking.supplier
    consignee = booking.consignee
    supplier.update(params.require(:supplier).permit(permited_attributes))
    consignee.update(params.require(:consignee).permit(permited_attributes))
    booking.update(cargo_description: params[:cargo_description])
    render nothing: true
  end

  def suppliers_consignees_destroy
    @address_book = AddressBook.where(id: params[:ids])
    @address_book.destroy_all
    render nothing: true 
  end

  def add_supplier_consignee
    booking_id = params[:booking_id] || session[:cart].keys.first
    @booking = Booking.find(booking_id)
    @supplier_address = @booking.supplier || AddressBook.new(address_type: 'supplier')
    @consignee_address = @booking.supplier || AddressBook.new(address_type: 'consignee')
    if request.xhr?
      render partial: "address_books/supplier_consignee_form"
    end    
  end

  def check_address_and_redirect
    cart = session[:cart]
    booking_ids = cart.keys
    bookings = Booking.where(id: booking_ids)
    if bookings.map(&:supplier).compact.count != bookings.count && bookings.map(&:consignee).compact.count != bookings.count
      render nothing: true, status: 202
    else
      render nothing: true
    end  
  end

  protected

  def redirect_if_cart_empty
    redirect_to(root_path) and return if session[:cart].nil?  
  end

end
