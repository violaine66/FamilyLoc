class ReservationMailer < ApplicationMailer
  default from:  ENV['GMAIL_ADDRESS']

  def reservation_request_email
    @reservation = params[:reservation]
    @propriete = @reservation.propriete
    @user = @reservation.user
    mail(
      to: @user.email,
      subject: "Votre demande de réservation a été bien été envoyée et est en attente de validation"
    )
  end

  def notif_admin
    @reservation = params[:reservation]
    @propriete = @reservation.propriete
    @user = @reservation.user

    mail(
      to: " #{ENV['GMAIL_ADDRESS']}",
      subject: "Nouvelle demande de réservation"
    )
  end

end
