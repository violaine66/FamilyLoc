class ReservationReminderJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    reservation = Reservation.find_by(id: reservation_id)
    return unless reservation && reservation.date_debut > Date.today

    AdminMailer.reservation_reminder(reservation: reservation).deliver_now
  end
end
