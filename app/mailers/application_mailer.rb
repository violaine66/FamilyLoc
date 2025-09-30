class ApplicationMailer < ActionMailer::Base
    default from: ENV['ADMIN1']

  layout "mailer"
end
