class AdminMailer < ApplicationMailer
    default from: ENV['GMAIL_ADDRESS']


  def reservation_reminder
    @reservation = params[:reservation]
    mail(to: [ENV['GMAIL_ADDRESS'],  ENV['ADMIN2']], subject: "Rappel réservation dans 7 jours")
  end
end
