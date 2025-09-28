class AdminMailer < ApplicationMailer
    default from: ENV['USERNAME'] # contact@family-loc.store


  def reservation_reminder
    @reservation = params[:reservation]
    mail(to: ENV['USERNAME'], subject: "Rappel réservation dans 7 jours")
  end
end
