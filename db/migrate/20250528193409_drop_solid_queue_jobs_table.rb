class DropSolidQueueJobsTable < ActiveRecord::Migration[6.0]
  def up
    execute "DROP TABLE solid_queue_jobs CASCADE"

  end

  def down
    # Optionnel : recréer la table si rollback
  end
end
