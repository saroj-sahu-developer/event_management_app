class Event < ApplicationRecord
  belongs_to :organizer, class_name: 'User', foreign_key: 'organizer_id'
  has_many :tickets, dependent: :nullify
  has_many :bookings, dependent: :nullify

  validates :name, :date, :venue, presence: true
end
