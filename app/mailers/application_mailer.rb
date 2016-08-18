class ApplicationMailer < ActionMailer::Base
  default from: %("Exchanging of Wows" <#{ENV['MAILER_FROM']}>)
  layout 'mailer'
end
