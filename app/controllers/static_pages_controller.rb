class StaticPagesController < ApplicationController
  def home
    @rsvp = Rsvp.find_or_initialize_by(ip: request.remote_ip)
  end

  def portland
  end
end
