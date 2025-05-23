class AdminMailer < ApplicationMailer
  default from: 'Notification@family-loc.fr'

  def reservation_reminder
    @reservation = params[:reservation]
    @user = @reservation.user
    @propriete = @reservation.propriete

    mail(
      to: "#{ENV['GMAIL_ADDRESS']}",
      subject: "Rappel de réservation sur Family-Loc"
    )
  end
end
