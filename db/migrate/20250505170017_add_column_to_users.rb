class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :nom_complet, :string
    add_column :users, :admin, :boolean, default: false
  end
end
