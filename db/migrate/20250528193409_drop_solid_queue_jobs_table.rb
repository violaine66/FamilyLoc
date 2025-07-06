
class DropSolidQueueJobsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :solid_queue_jobs, if_exists: true
  end
end
