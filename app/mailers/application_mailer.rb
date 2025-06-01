class ApplicationMailer < ActionMailer::Base
   default from: ENV.fetch('MAIL_FROM', 'FamilyLoc <vhsoulas@gmail.com>')
  layout "mailer"
end
