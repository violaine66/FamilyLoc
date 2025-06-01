class AdminMailer < ApplicationMailer
    default from: ENV.fetch('MAIL_FROM', 'FamilyLoc <8e5a83001@smtp-brevo.com>')


  def reservation_reminder
    @reservation = params[:reservation]
    mail(to: [ENV['USERNAME'],  ENV['ADMIN2']], subject: "Rappel réservation dans 7 jours")
  end
end
