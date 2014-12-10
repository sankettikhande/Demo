class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [:seller, :buyer, :admin, :guest]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :confirmable, :lockable

  mount_uploader :avatar, AvatarUploader

  validate :avatar_size_validation

  has_many :seller_bookings, class_name: "Booking", foreign_key: "seller_id"
  has_many :buyer_bookings, class_name: "Booking", foreign_key: "buyer_id"
  has_many :address_books       
  has_many :freights, foreign_key: "seller_id"
  def avatar_size_validation
    errors[:avatar] << "should be less than 5MB" if avatar && avatar.size > 5.megabytes
  end

end
