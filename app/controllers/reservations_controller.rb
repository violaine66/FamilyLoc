class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end

  def create
    @propriete = Propriete.find(params[:propriete_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.propriete = @propriete
    @reservation.user = current_user

    if @reservation.save
      redirect_to propriete_reservation_path(@propriete, @reservation), notice: 'La demande de réservation a été créée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end
end
