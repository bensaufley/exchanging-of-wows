class NotificationMailer < ApplicationMailer
  default to: ENV['NOTIFICATION_EMAILS'].split(',')

  def new_rsvp(rsvp)
    @rsvp = rsvp
    mail(subject: "#{rsvp.names.to_sentence} #{rsvp.names.length > 1 ? 'have' : 'has'} RSVPed")
  end
end
