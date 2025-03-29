class TicketConfirmationJob
  include Sidekiq::Job

  def perform(booking_id)
    booking = Booking.find_by(id: booking_id)
    return unless booking

    puts "Email confirmation will be sent to #{booking.customer.email} for booking ID #{booking.id}."
  end
end
