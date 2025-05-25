class Admin::ReservationsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
   query = params[:query].to_s.strip

    base_scope = policy_scope(Reservation).includes(:user, :propriete).order(:date_debut)

    @reservations = query.present? ? base_scope.global_search(query) : base_scope
    authorize @reservations
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
