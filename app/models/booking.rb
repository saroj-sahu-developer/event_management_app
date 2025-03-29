class Booking < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  belongs_to :event
  belongs_to :ticket

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validate :enough_tickets_available, on: :create

  before_validation :calculate_total_price
  after_create :reduce_ticket_quantity
  after_destroy :restore_ticket_quantity

  after_create :schedule_email_confirmation
  
  private

  def calculate_total_price
    self.total_price = ticket.price * quantity if ticket
  end

  def reduce_ticket_quantity
    ticket.update!(quantity_available: ticket.quantity_available - quantity)
  end

  def restore_ticket_quantity
    ticket.update!(quantity_available: ticket.quantity_available + quantity)
  end

  
  def enough_tickets_available
    if ticket.quantity_available < quantity
      errors.add(:quantity, "only #{ticket.quantity_available} tickets available.")
    end
  end

  def schedule_email_confirmation
    TicketConfirmationJob.perform_in(1.minute, id)
  end
end
