class StaticPagesController < ApplicationController
  def home
    @rsvp = Rsvp.new
    @song_request = SongRequest.new
  end

  def portland
  end

  def jelena_ben
  end
end
