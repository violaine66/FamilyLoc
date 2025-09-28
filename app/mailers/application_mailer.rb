class ApplicationMailer < ActionMailer::Base
    default from: ENV['USERNAME'] # contact@family-loc.store

  layout "mailer"
end
