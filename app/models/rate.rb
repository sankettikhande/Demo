class Rate < ActiveRecord::Base

  belongs_to :booking
  belongs_to :user, class_name: 'User', foreign_key: 'reteable_id'

  validate :allow_rating_once
  

  def allow_rating_once
    if Rate.exists?(booking_id: booking_id, rater_id: rater_id)
      errors.add(:base, "you already rated for this booking.")
    end
  end
end
