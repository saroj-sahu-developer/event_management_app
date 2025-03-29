class Event < ApplicationRecord
  belongs_to :organizer, class_name: 'User', foreign_key: 'organizer_id'
  has_many :tickets, dependent: :nullify
  has_many :bookings, dependent: :nullify

  validates :name, :date, :venue, presence: true

  after_update_commit :notify_customers

  private

  def notify_customers
    EventUpdateNotificationJob.perform_async(id)
  end
end
