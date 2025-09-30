class AdminMailer < ApplicationMailer
  # expéditeur par défaut
  default from: ENV['ADMIN1']

  def reservation_reminder
    @reservation = params[:reservation]

    mail(
      to: ENV['ADMIN1'],
      cc: [ENV['ADMIN2']], # tu peux ajouter d'autres adresses si besoin
      subject: "Rappel réservation dans 7 jours"
    )
  end
end
