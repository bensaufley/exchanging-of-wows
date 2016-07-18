class StaticPagesController < ApplicationController
  def home
    @rsvp = Rsvp.find_or_initialize_by(ip: request.remote_ip)
    @song_request = SongRequest.new
  end

  def portland
  end

  def jelena_ben
  end
end
