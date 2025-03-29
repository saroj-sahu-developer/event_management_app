class Ticket < ApplicationRecord
  belongs_to :event

  enum ticket_type: { general: 0, vip: 1, premium: 2 }

  validates :ticket_type, :price, :quantity_available, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity_available, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :normalize_ticket_type

  private

  def normalize_ticket_type
    return if ticket_type.blank?

    normalized_type = ticket_type.downcase.strip
    self.ticket_type = Ticket.ticket_types[normalized_type] if Ticket.ticket_types.key?(normalized_type)
  end
end
