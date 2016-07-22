class Rsvp < ApplicationRecord
  validates :first_name, :last_name, :plus_one, :ip, presence: true

  def self.head_count
    all.where(plus_one: true).count * 2 + all.where(plus_one: false).count
  end
end
