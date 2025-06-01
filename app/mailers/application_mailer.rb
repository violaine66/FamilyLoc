class ApplicationMailer < ActionMailer::Base
   default from: ENV.fetch('MAIL_FROM', 'FamilyLoc <8e5a83001@smtp-brevo.com>')

  layout "mailer"
end
