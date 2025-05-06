class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = policy_scope(Reservation)
   authorize @reservations
  end

  def show
    @reservation = Reservation.find(params[:id])
    @propriete = @reservation.propriete
    authorize @reservation
  end


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
      redirect_to propriete_path(@propriete), notice: 'La demande de réservation a été créée avec succès.'
    else
      render "proprieres/show", status: :unprocessable_entity
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:date_debut, :date_fin, :number_of_guests)
  end
end
