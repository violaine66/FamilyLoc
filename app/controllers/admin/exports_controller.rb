class Admin::ExportsController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  def attendances
    start_date = params[:start_date].presence || 1.month.ago.to_date
    end_date = params[:end_date].presence || Date.today
    format = params[:format_export] || 'csv' # csv par défaut

    service = PlayerAttendanceExportService.new(start_date: start_date, end_date: end_date)

    case format
    when 'csv'
      csv_data = service.generate_csv
      send_data csv_data,
        filename: "etat_presences_#{start_date}_#{end_date}.csv",
        type: 'text/csv',
        disposition: 'attachment'

    when 'xlsx'
      xlsx_data = service.generate_xlsx
      send_data xlsx_data,
        filename: "etat_presences_#{start_date}_#{end_date}.xlsx",
        type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        disposition: 'attachment'

    when 'pdf'
      pdf_data = service.generate_pdf
      send_data pdf_data,
        filename: "etat_presences_#{start_date}_#{end_date}.pdf",
        type: 'application/pdf',
        disposition: 'attachment'

    else
      redirect_to admin_exports_path, alert: "Format non supporté."
    end
  end

  private

  def authenticate_admin!
    allowed_roles = ["entraineur", "admin"]
    unless allowed_roles.include?(current_user&.role)
      redirect_to root_path, alert: "Accès réservé aux administrateurs."
    end
  end
end

end
