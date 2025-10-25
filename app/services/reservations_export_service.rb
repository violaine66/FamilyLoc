require 'csv'
require 'axlsx'
require 'prawn'

class ReservationsExportService
  def initialize(start_date:, end_date:)
    @start_date = start_date
    @end_date = end_date
  end

  def generate_csv
    CSV.generate(headers: true) do |csv|
      csv << ["Nom de la propriété", "Nom complet de l'utilisateur", "Date début", "Date fin"]
      reservations.each do |r|
        csv << [r.propriete.nom, r.user.nom_complet, r.date_debut, r.date_fin]
      end
    end
  end

  def generate_xlsx
    package = Axlsx::Package.new
    wb = package.workbook
    wb.add_worksheet(name: "Reservations") do |sheet|
      sheet.add_row ["Nom de la propriété", "Nom complet de l'utilisateur", "Date début", "Date fin"]
      reservations.each do |r|
        sheet.add_row [r.propriete.nom, r.user.nom_complet, r.date_debut, r.date_fin]
      end
    end
    package.to_stream.read
  end

 def generate_pdf
  Prawn::Document.new do |pdf|
    pdf.text "Liste des réservations", size: 18, style: :bold, align: :center
    pdf.move_down 20

    # Construire le tableau
    data = [["Nom de la propriété", "Nom complet de l'utilisateur", "Date début", "Date fin"]]
    reservations.each do |r|
      data << [r.propriete.nom, r.user.nom_complet, r.date_debut.strftime("%d/%m/%Y"), r.date_fin.strftime("%d/%m/%Y")]
    end

    # Générer le tableau
    pdf.table(data, header: true, row_colors: ["DDDDDD", "FFFFFF"], width: pdf.bounds.width) do
      row(0).font_style = :bold
      row(0).background_color = "AAAAAA"
      columns(2..3).align = :center
      self.cell_style = { borders: [:top, :bottom, :left, :right], padding: [5, 10, 5, 10] }
    end
  end.render
end

  private

 def reservations
    @reservations ||= Reservation
                        .where(date_debut: @start_date..@end_date)
                        .includes(:propriete, :user) # <- précharge les associations
  end

end
