class Rsvp < ApplicationRecord
  validates :first_name, :last_name, :guests, :ip, presence: true
end
