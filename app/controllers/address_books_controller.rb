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
    supplier_params = params.require(:supplier).permit(permited_attributes)
    consignee_params = params.require(:consignee).permit(permited_attributes)   
    booking = Booking.find(params[:booking_id])
    supplier = current_user.address_books.where(supplier_params).first || current_user.address_books.new(address_type: 'supplier')
    consignee = current_user.address_books.where(consignee_params).first || current_user.address_books.new(address_type: 'consignee')
    booking.update(cargo_description: params[:cargo_description], supplier_id: supplier.id, consignee_id: consignee.id)
    render js: "alert('Added')"
  end

  def suppliers_consignees_destroy
    @address_book = AddressBook.where(id: params[:ids])
    @address_book.destroy_all
    render nothing: true 
  end

  def add_supplier_consignee
    booking_id = params[:booking_id] || session[:cart].keys.first
    @booking = Booking.find(booking_id)
    supplier_address_book = current_user.address_books.supplier_address.where(id: params[:supplier_address_book_id]).first
    consignee_address_book = current_user.address_books.consignee_address.where(id: params[:consignee_address_book_id]).first

    if supplier_address_book || consignee_address_book
      @booking.supplier = supplier_address_book
      @booking.consignee = consignee_address_book   
    end

    @supplier_address = @booking.supplier || AddressBook.new(address_type: 'supplier')
    @consignee_address = @booking.consignee || AddressBook.new(address_type: 'consignee')
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
