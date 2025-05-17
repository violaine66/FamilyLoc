class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = policy_scope(Reservation)
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
      ReservationMailer.with(reservation: @reservation).reservation_request_email.deliver_now
      ReservationMailer.with(reservation: @reservation).notif_admin.deliver_now

      redirect_to propriete_path(@propriete), notice: 'La demande de réservation a été créée avec succès et est en attente de validation.'
    else
      render "proprietes/show", status: :unprocessable_entity
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @propriete = @reservation.propriete
    @reservation.user = current_user
    authorize @reservation
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    authorize @reservation
    @reservation.destroy
    redirect_to reservations_path, notice: 'La réservation a été annulée avec succès.'
  end

  def update_statut
    @reservation = Reservation.find(params[:id])
    authorize @reservation, :update_statut?


    if @reservation.update(statut: params[:reservation][:statut])  # Récupérer le statut du formulaire
       ReservationMailer.with(reservation: @reservation).reservation_confirmation_update.deliver_now
      render json: { success: true, statut: @reservation.statut, message: 'Le statut de la réservation a été mis à jour avec succès.' }, status: :ok
    else
      render json: { success: false, errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:date_debut, :date_fin, :number_of_guests)
  end
end
