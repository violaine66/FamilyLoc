class AdminMailer < ApplicationMailer
    default from: ENV['USERNAME']


  def reservation_reminder
    @reservation = params[:reservation]
    mail(to: [ENV['ADMIN1'],  ENV['ADMIN2']], subject: "Rappel réservation dans 7 jours")
  end
end
