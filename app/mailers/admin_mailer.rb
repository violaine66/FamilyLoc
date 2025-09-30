class AdminMailer < ApplicationMailer
    default from: ENV['ADMIN1'], cc: ENV['ADMIN2']


  def reservation_reminder
    @reservation = params[:reservation]
    mail(to: ENV['ADMIN1'], cc: ENV['ADMIN2'], subject: "Rappel réservation dans 7 jours")
  end
end
