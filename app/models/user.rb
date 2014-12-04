class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [:seller, :buyer, :admin]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :confirmable, :lockable

  has_many :seller_bookings, class_name: "Booking", foreign_key: "seller_id"
  has_many :buyer_bookings, class_name: "Booking", foreign_key: "buyer_id"
         
end
