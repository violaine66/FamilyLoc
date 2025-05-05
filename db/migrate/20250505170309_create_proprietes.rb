class CreateProprietes < ActiveRecord::Migration[7.1]
  def change
    create_table :proprietes do |t|
      t.string :nom
      t.string :adresse

      t.timestamps
    end
  end
end
