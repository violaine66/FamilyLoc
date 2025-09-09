class AddColumnToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :nom, :string
  end
end
