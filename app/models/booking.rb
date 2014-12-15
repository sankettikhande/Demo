class Booking < ActiveRecord::Base

  belongs_to :supplier, class_name: "AddressBook", foreign_key: "supplier_id"
  belongs_to :consignee, class_name: "AddressBook", foreign_key: "consignee_id"

  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id"
  has_many :payments

  validates_inclusion_of :aasm_state, :in => ['draft', 'active', 'hold', 'confirmed', 'pending']
  validates :buyer_id, :aasm_state, :source, :destination, :freight_type, :cbm, :weight, :pick_up_date, presence: true
  
  scope :active_bookings, -> {where(aasm_state: 'active')}
  scope :bookings_on_hold, -> {where(aasm_state: 'hold')}
  scope :draft_bookings, -> {where(aasm_state: 'draft')}
  scope :archived_bookings, -> {where(is_archived: true)}
  scope :confirmed_bookings, -> {where(aasm_state: 'confirmed')}

  def is_draft?
    aasm_state == "draft"
  end

  def is_hold?
    aasm_state == "hold"
  end

end
