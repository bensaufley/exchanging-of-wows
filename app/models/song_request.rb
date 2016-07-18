class SongRequest < ApplicationRecord
  validates :name, :artist, :album, :info, presence: true

  def self.build_from_json(json)
    song = new
    song.name = json[:name]
    song.artist = json[:artists].first[:name]
    song.album = json[:album][:name]
    song.info = json
    song
  end

  def info
    (self[:info] || {}).with_indifferent_access
  end

  def img(max_width)
    info[:album][:images].select { |img| img[:height] < max_width }&.first&.fetch(:url)
  end
end
