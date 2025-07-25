class Reservation < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  belongs_to :propriete
  validates :date_debut, presence: true
  validates :date_fin, presence: true

  validate :no_overlap_with_existing_reservations
  validate :date_debut_must_be_before_date_fin, on: :create

    enum statut: {
    en_attente: "en_attente",
    confirmée: "confirmée",
    annulée: "annulée"
  }

  validates :statut, presence: true, inclusion: { in: statuts.keys }

  pg_search_scope :global_search,
    against: [ :date_debut, :date_fin],
    associated_against: {
      user: [ :nom_complet, :email ],
      propriete: [ :adresse]
    },
    using: {
      tsearch: { prefix: true }
    }

  private

  def date_debut_must_be_before_date_fin
    if date_debut.present? && date_fin.present? && date_debut >= date_fin
      errors.add(:date_debut, "doit être avant la date de fin")
    end
  end

    # Validation pour vérifier les chevauchements avec des réservations existantes
   def no_overlap_with_existing_reservations
    if new_record?
    conflicting_reservations = propriete.reservations.where('date_debut < ? AND date_fin > ?', date_fin, date_debut).exists?
    errors.add(:base, "Les dates choisies sont déjà réservées") if conflicting_reservations
    end
  end

  def self.send_admin_reminders
    Rails.logger.info "[Scheduler] send_admin_reminders démarré à #{Time.current}"
  File.open(Rails.root.join("log", "reminder.log"), "a") do |f|
    f.puts "send_admin_reminders called at #{Time.now}"
  end

  date_cible = Date.today + 7.days
  reservations = where(date_debut: date_cible)

  reservations.find_each do |reservation|
    AdminMailer.with(reservation: reservation).reservation_reminder.deliver_now
    Rails.logger.info "Rappel envoyé pour réservation ##{reservation.id}"
  end
end

end
