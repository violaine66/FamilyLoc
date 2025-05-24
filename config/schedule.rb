# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# set :output, "log/cron_log.log"
# set :environment, 'development'

# set :environment, 'production'
# every 1.day, at: '9:00 am' do
#   runner "Reservation.send_admin_reminders"
# end

# Reservation.send_admin_reminders

# Mettre à jour à chaque modification
# whenever --update-crontab
# config/schedule.rb

# config/schedule.rb

# set :output, "/home/violaine/FamilyLoc/log/cron_log.log" # Chemin complet vers le fichier log
# set :environment, 'production'  # ou 'development' si tu testes en local

# every 1.day, at: '9:00 am' do
#   runner "Reservation.send_admin_reminders"
# end


# config/schedule.rb

set :output, "log/cron_log.log"
set :environment, "development" # ou 'production' selon ton environnement

every 1.minute do
  runner "Reservation.send_admin_reminders"
end
