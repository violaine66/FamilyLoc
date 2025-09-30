class ReservationMailer < ApplicationMailer
   default from: ENV['ADMIN1']


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
      to: ENV['ADMIN1'],
      cc: ENV['ADMIN2'],
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
      to: @user.email,
      cc: [ENV['ADMIN1'], ENV['ADMIN2']],
      subject: "Annulation de votre réservation"
    )
  end


end
