class AdminMailer < ApplicationMailer
    default from: ENV['user_name'] # contact@family-loc.store


  def reservation_reminder
    @reservation = params[:reservation]
    mail(to: ENV['user_name'], subject: "Rappel réservation dans 7 jours")
  end
end
