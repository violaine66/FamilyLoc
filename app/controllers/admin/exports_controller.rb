class Admin::ExportsController < ApplicationController
  before_action :authenticate_admin!
  skip_after_action :verify_policy_scoped, only: :index

  def index
    authorize :export, :index?
  end

  def reservations
    authorize Reservation, :export?

    # 🟢 Correction : correspond aux champs du formulaire
    start_date = params[:date_debut].presence || 1.month.ago.to_date
    end_date   = params[:date_fin].presence || Date.today
    format     = params[:format_export] || 'pdf'

    service = ReservationsExportService.new(
      start_date: start_date,
      end_date: end_date
    )

    case format
    when 'csv'
      send_data service.generate_csv,
        filename: "etat_reservations_#{start_date}_#{end_date}.csv",
        type: 'text/csv',
        disposition: 'attachment'

    when 'xlsx'
      send_data service.generate_xlsx,
        filename: "etat_reservations_#{start_date}_#{end_date}.xlsx",
        type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        disposition: 'attachment'

    when 'pdf'
      send_data service.generate_pdf,
        filename: "etat_reservations_#{start_date}_#{end_date}.pdf",
        type: 'application/pdf',
        disposition: 'attachment'

    else
      redirect_to admin_exports_path, alert: "Format non supporté."
    end
  end

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Accès réservé aux administrateurs."
    end
  end
end
