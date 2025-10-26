require 'csv'
require 'axlsx'
require 'prawn'

class ReservationsExportService
  def initialize(start_date:, end_date:)
    @start_date = start_date
    @end_date = end_date
  end

  # -----------------------------
  # 📊 EXPORT CSV
  # -----------------------------
  def generate_csv
    CSV.generate(headers: true) do |csv|
      csv << ["Nom de la propriété", "Nom complet de l'utilisateur", "Date début", "Date fin"]
      reservations.each do |r|
        csv << [
          r.propriete.nom,
          r.user.nom_complet,
          r.date_debut.strftime("%d/%m/%Y"),
          r.date_fin.strftime("%d/%m/%Y")
        ]
      end
    end
  end

  # -----------------------------
  # 📘 EXPORT XLSX
  # -----------------------------
  def generate_xlsx
    package = Axlsx::Package.new
    wb = package.workbook
    wb.add_worksheet(name: "Réservations") do |sheet|
      sheet.add_row ["Nom de la propriété", "Nom complet de l'utilisateur", "Date début", "Date fin"]
      reservations.each do |r|
        sheet.add_row [
          r.propriete.nom,
          r.user.nom_complet,
          r.date_debut.strftime("%d/%m/%Y"),
          r.date_fin.strftime("%d/%m/%Y")
        ]
      end
    end
    package.to_stream.read
  end

  # -----------------------------
  # 🧾 EXPORT PDF
  # -----------------------------
  def generate_pdf
    Prawn::Document.new(page_size: 'A4') do |pdf|
      pdf.text "Liste des réservations", size: 18, style: :bold, align: :center
      pdf.move_down 20

      # Données du tableau
      data = [["Nom de la propriété", "Nom complet de l'utilisateur", "Date début", "Date fin"]]
      reservations.each do |r|
        data << [
          r.propriete.nom,
          r.user.nom_complet,
          r.date_debut.strftime("%d/%m/%Y"),
          r.date_fin.strftime("%d/%m/%Y")
        ]
      end

      # Rendu du tableau
      pdf.table(data, header: true, row_colors: ["F0F0F0", "FFFFFF"], width: pdf.bounds.width) do
        row(0).font_style = :bold
        row(0).background_color = "DDDDDD"
        columns(0..3).align = :center
        self.cell_style = { borders: [:left, :right, :top, :bottom], size: 10 }
      end
    end.render
  end

  private

  # -----------------------------
  # 🔍 Récupération des réservations
  # -----------------------------
  def reservations
    start = Date.parse(@start_date.to_s) rescue nil
    finish = Date.parse(@end_date.to_s) rescue nil

    scope = Reservation.includes(:propriete, :user)
    scope = scope.where(date_debut: start..finish) if start && finish
    scope.order(:date_debut)
  end
end
