class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: [:seller, :buyer, :admin, :guest]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :confirmable, :lockable

  mount_uploader :avatar, AvatarUploader

  validate :avatar_size_validation
  validates :first_name, :last_name, :company_name, :company_registration_number, :address_line_1, :post_code, :city, :state, :country, :phone_number, :presence => true

  has_one :user_information
  has_many :seller_bookings, class_name: "Booking", foreign_key: "seller_id"
  has_many :buyer_bookings, class_name: "Booking", foreign_key: "buyer_id"
  has_many :address_books       
  has_many :freights, foreign_key: "seller_id"
  has_many :buyer_payments, class: 'Payment', foreign_key: 'buyer_id'
  has_many :seller_payments, class: 'Payment', foreign_key: 'seller_id'
  has_many :rates, class_name: 'Rate', foreign_key: 'rateable_id' 
  default_scope {where(is_active: true)}

  def avatar_size_validation
    errors[:avatar] << "should be less than 5MB" if avatar && avatar.size > 5.megabytes
  end

  def validate_user(email, password)
    user = User.where(email: email).first
    user && user.valid_password?(password)
  end
end
