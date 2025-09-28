class ApplicationMailer < ActionMailer::Base
    default from: ENV['GMAIL_ADDRESS'] # contact@family-loc.store

  layout "mailer"
end
