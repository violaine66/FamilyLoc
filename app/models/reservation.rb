class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :propriete
  validates :date_debut, presence: true
  validates :date_fin, presence: true

  validate :date_debut_must_be_before_date_fin

  def date_debut_must_be_before_date_fin
    if date_debut.present? && date_fin.present? && date_debut >= date_fin
      errors.add(:date_debut, "doit être avant la date de fin")
    end
  end

    # Validation pour vérifier les chevauchements avec des réservations existantes
   def no_overlap_with_existing_reservations
    if new_record?
    conflicting_reservations = experience.reservations.where('date_de_debut < ? AND date_de_fin > ?', date_de_fin, date_de_debut).exists?
    errors.add(:base, "Les dates choisies sont déjà réservées") if conflicting_reservations
    end
  end
end
