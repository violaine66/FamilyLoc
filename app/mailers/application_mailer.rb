class ApplicationMailer < ActionMailer::Base
    default from: ENV['ADMIN1'], cc: ENV['ADMIN2']

  layout "mailer"
end
