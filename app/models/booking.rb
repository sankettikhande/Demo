class Booking < ActiveRecord::Base

  include AASM

  belongs_to :supplier, class_name: "AddressBook", foreign_key: "supplier_id"
  belongs_to :consignee, class_name: "AddressBook", foreign_key: "consignee_id"

  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id"
  has_many :payments, through: :booking_payments
  has_many :booking_payments
  validates_inclusion_of :aasm_state, :in => ['draft', 'active', 'hold', 'confirmed', 'negotiation']
  validates :buyer_id, :aasm_state, :source, :destination, :freight_type, :length, :height, :width, :weight, :pick_up_date, presence: true
  
  scope :active, -> {where(aasm_state: 'active')}
  scope :on_hold, -> {where(aasm_state: 'hold')}
  scope :draft, -> {where(aasm_state: 'draft')}
  scope :archived, -> {where(is_archived: true)}
  scope :confirmed, -> {where(aasm_state: 'confirmed')}
  scope :pending_negotiations, -> {where(aasm_state: 'negotiation')}
  scope :pending_confirmations, -> {where(aasm_state: ['active', 'hold'])}

  def is_draft?
    aasm_state == "draft"
  end

  def is_hold?
    aasm_state == "hold"
  end


  aasm do
    state :draft, initial: true
    state :active
    state :hold
    state :confirmed
    state :cancelled


    event :draft_to_active do
      transitions from: :draft, to: :active
    end

    event :active_to_confirmed do
      transitions from: :active, to: :confirmed do
        after do
          BookingMailer.seller_booking_confirmation( self ).deliver
          BookingMailer.buyer_booking_confirmation( self ).deliver
        end
      end
    end

    event :active_to_hold do
      transitions from: :active, to: :hold do
        after do
          BookingMailer.seller_booking_rejection( self ).deliver
          BookingMailer.buyer_booking_rejection( self ).deliver
        end
      end
    end

    event :hold_to_active do
      transitions from: :hold, to: :active do
        after do
          BookingMailer.seller_active_booking( self ).deliver
          BookingMailer.buyer_active_booking( self ).deliver
        end
      end
    end

    event :confirmed_to_hold do
      transitions from: :confirmed, to: :hold do
        after do
          BookingMailer.seller_booking_rejection( self ).deliver
          BookingMailer.buyer_booking_rejection( self ).deliver
        end
      end
    end

    event :active_to_cancelled do
      transitions from: :active, to: :cancelled do
        after do
          BookingMailer.seller_booking_cancellation( self ).deliver
          BookingMailer.buyer_booking_cancellation( self ).deliver
        end
      end
    end
  end

end
