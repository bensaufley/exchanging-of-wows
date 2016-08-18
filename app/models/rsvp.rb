class Rsvp < ApplicationRecord
  validates :names, :ip, presence: true
  validates :attending, inclusion: { in: [true, false] }

  def names
    self[:names]&.split(/, */)
  end

  def self.head_count
    where(attending: true).map(&:names).flatten.length
  end
end
