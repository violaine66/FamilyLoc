class Admin::ReservationsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @reservations = policy_scope(Reservation).includes(:user, :propriete).order(created_at: :desc)
    authorize Reservation
  end

  def show
    @reservation = Reservation.find(params[:id])
    authorize @reservation
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    authorize @reservation
    @reservation.destroy
    redirect_to admin_reservations_path, notice: "Réservation supprimée."
  end
end
