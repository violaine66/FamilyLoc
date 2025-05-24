#!/bin/bash
echo "Début du cron à $(date)" >> /home/violaine/FamilyLoc/log/cron_env.log

cd /home/violaine/FamilyLoc || exit

export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"

which ruby >> /home/violaine/FamilyLoc/log/cron_env.log 2>&1
which bundle >> /home/violaine/FamilyLoc/log/cron_env.log 2>&1

bundle exec rails runner -e development 'Reservation.send_admin_reminders' >> /home/violaine/FamilyLoc/log/cron_env.log 2>&1

echo "Fin du cron à $(date)" >> /home/violaine/FamilyLoc/log/cron_env.log
