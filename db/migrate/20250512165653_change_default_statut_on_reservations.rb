class ChangeDefaultStatutOnReservations < ActiveRecord::Migration[7.1]
  def change
    change_column_default :reservations, :statut, from: nil, to: "en_attente"
  end
end
