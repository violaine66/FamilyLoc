class AdminMailer < ApplicationMailer
    default from: '8e5a83001@smtp-brevo.com'


  def reservation_reminder
    @reservation = params[:reservation]
    mail(to: ['vhsoulas@gmail.com',  ENV['ADMIN2']], subject: "Rappel réservation dans 7 jours")
  end
end
