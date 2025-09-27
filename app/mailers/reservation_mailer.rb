class ReservationMailer < ApplicationMailer
   default from: ENV['user_name'] #


  def reservation_request_email
    @reservation = params[:reservation]
    @propriete = @reservation.propriete
    @user = @reservation.user
    mail(
      to: @user.email,
      subject: "Votre demande de réservation a bien été envoyée et est en attente de validation"
    )
  end

  def notif_admin
    @reservation = params[:reservation]
    @propriete = @reservation.propriete
    @user = @reservation.user

      mail(
      to: ENV['user_name'],
      subject: "Nouvelle demande de réservation"
    )

  end

  def reservation_confirmation_update
    @reservation = params[:reservation]
    @propriete = @reservation.propriete
    @user = @reservation.user

    mail(
      to: @user.email,
      subject: "Mise à jour de votre demande de réservation"
    )
  end

  def reservation_cancellation_by_user
    @reservation = params[:reservation]
    @propriete = @reservation.propriete
    @user = @reservation.user

    mail(
      to: @user.email, cc: ENV['user_name'],
      subject: "Annulation de votre réservation"
    )
  end

end
