class AdminMailer < ApplicationMailer
    default from: ENV.fetch('MAIL_FROM', 'FamilyLoc <vhsoulas@gmail.com>')

  def reservation_reminder
    @reservation = params[:reservation]
    mail(to: [ENV['GMAIL_ADDRESS'],  ENV['ADMIN2']], subject: "Rappel réservation dans 7 jours")
  end
end
