class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.date :date_debut
      t.date :date_fin
      t.string :statut
      t.references :user, null: false, foreign_key: true
      t.references :propriete, null: false, foreign_key: true

      t.timestamps
    end
  end
end
