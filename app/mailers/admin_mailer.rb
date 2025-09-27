class AdminMailer < ApplicationMailer
    default from: ENV['ZOHO_USERNAME']


  def reservation_reminder
    @reservation = params[:reservation]
    mail(to: ENV['ZOHO_USERNAME'], subject: "Rappel réservation dans 7 jours")
  end
end
