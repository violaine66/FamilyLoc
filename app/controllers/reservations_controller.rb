class ReservationsController < ApplicationController

  def new
    @propriete = Propriete.find(params[:propriete_id])
    @reservation = Reservation.new
    authorize @reservation
  end

  def create
    @propriete = Propriete.find(params[:propriete_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.propriete = @propriete
    @reservation.user = current_user
    authorize @reservation

    if @reservation.save
      redirect_to @propriete, notice: 'La demande de réservation a été créée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:date_debut, :date_fin, :number_of_guests)
  end
end
