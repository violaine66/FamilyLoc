class ProprietesController < ApplicationController
    skip_after_action :verify_authorized, only: :index
    skip_after_action :verify_policy_scoped, only: :index

  def index
    @proprietes = Propriete.all
  end

  def show
    @propriete = Propriete.find(params[:id])
    @reservation = Reservation.new
    authorize @propriete
  end
end
