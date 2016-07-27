class Rsvp < ApplicationRecord
  validates :first_name, :last_name, :ip, presence: true
  validates :plus_one, :attending, inclusion: { in: [true, false] }
  before_save :no_plus_one_for_non_attendees

  def self.head_count
    all.where(attending: true, plus_one: true).count * 2 + all.where(attending: true, plus_one: false).count
  end

  private

  def no_plus_one_for_non_attendees
    self.plus_one = false unless self.attending?
  end
end
