class AdminMailer < ApplicationMailer
    default from: ENV['GMAIL_ADDRESS'] # contact@family-loc.store


  def reservation_reminder
    @reservation = params[:reservation]
    mail(to: ENV['GMAIL_ADDRESS'], cc: ENV['ADMIN2'], subject: "Rappel réservation dans 7 jours")
  end
end
