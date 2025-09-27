class ApplicationMailer < ActionMailer::Base
    default from: ENV['user_name'] # contact@family-loc.store

  layout "mailer"
end
