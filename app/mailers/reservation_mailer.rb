class ReservationMailer < ApplicationMailer
  default from: 'family-loc@app.fr'

  def reservation_request_email
    @reservation = params[:reservation]
    @propriete = @reservation.propriete
    @user = @reservation.user
    mail(
      to: @user.email,
      subject: "Votre demande de réservation a été bien été envoyée et est en attente de validation"
    )
  end
end
