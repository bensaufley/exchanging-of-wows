class Rsvp < ApplicationRecord
  validates :names, :ip, presence: true
  validates :attending, inclusion: { in: [true, false] }

  def names
    self[:names]&.split(/, */)
  end

  def self.head_count
    all.map(&:names).flatten.length
  end
end
