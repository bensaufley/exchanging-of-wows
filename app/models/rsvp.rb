class Rsvp < ApplicationRecord
  validates :names, :ip, presence: true
  validates :attending, inclusion: { in: [true, false] }
  before_save :no_plus_one_for_non_attendees

  def names
    self[:names]&.split(/, */)
  end

  def self.head_count
    all.map(&:names).flatten.length
  end
end
