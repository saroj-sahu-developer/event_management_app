class EventUpdateNotificationJob
  include Sidekiq::Job

  def perform(event_id)
    event = Event.find_by(id: event_id)
    return unless event

    customers = User.joins(:bookings).where(bookings: { event_id: event.id }).distinct

    customers.each do |customer|
      puts "Sending email notification to #{customer.email} about the updated event: #{event.name}"
    end
  end
end
