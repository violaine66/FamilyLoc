class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = policy_scope(Reservation).includes(:user, :propriete).order(created_at: :desc)
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
       flash.now[:alert] = @reservation.errors.full_messages.first
      render 'proprietes/show', status: :unprocessable_entity
    end
  end

#   def edit
#     @reservation = Reservation.find(params[:id])
#     @propriete = @reservation.propriete
#     @reservation.user = current_user
#     authorize @reservation
#   end

#   def update
#   @reservation = Reservation.find(params[:id])
#   @propriete = @reservation.propriete
#   authorize @reservation

#   if @reservation.update(reservation_params)
#     redirect_to propriete_path(@propriete), notice: "La réservation a bien été modifiée ✅"
#   else
#     render :edit, status: :unprocessable_entity
#   end
# end



  def destroy
    @reservation = Reservation.find(params[:id])
    authorize @reservation
    if @reservation.destroy
        ReservationMailer.with(reservation: @reservation).reservation_cancellation_by_user.deliver_now
    redirect_to reservations_path, notice: 'La réservation a été annulée avec succès.'
    end
  end

  def update_statut
  @reservation = Reservation.find(params[:id])
  authorize @reservation, :update_statut?

    if @reservation.update(statut: params[:reservation][:statut])
      ReservationMailer.with(reservation: @reservation).reservation_confirmation_update.deliver_now
      redirect_to reservations_path, notice: "Le statut a été mis à jour avec succès."
    else
      redirect_to reservations_path, alert: @reservation.errors.full_messages.join(", ")
    end
  end





  def calendar
    @year = params[:year]&.to_i || Date.today.year
    @month = params[:month]&.to_i || Date.today.month
    @reservations = Reservation.where(statut: 'confirmée')

    authorize Reservation
  end


  private
  def reservation_params
    params.require(:reservation).permit(:date_debut, :date_fin, :nom)
  end
end
