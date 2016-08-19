class NotificationMailer < ApplicationMailer
  default to: ENV['NOTIFICATION_EMAILS'].split(',')

  def new_rsvp(rsvp)
    @rsvp = rsvp
    mail(subject: "#{rsvp.names.to_sentence} #{rsvp.names.length > 1 ? 'have' : 'has'} RSVPed")
  end

  def new_song_request(song_request)
    @song_request = song_request
    @rsvp = Rsvp.find_by(ip: song_request.ip)
    requester = if @rsvp.present?
      "#{@rsvp.names.to_sentence} #{@rsvp.names.length > 1 ? 'have' : 'has'}"
    else
      'Someone has'
    end
    mail(subject: "#{requester} requested a song")
  end
end
