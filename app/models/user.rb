class User < ApplicationRecord
  has_secure_password
  
  has_many :events, foreign_key: :organizer_id, dependent: :nullify
  has_many :bookings, foreign_key: :customer_id, dependent: :nullify

  validates :name, :email, :role, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: %w(customer, organizer), message: "must be 'customer' or 'organizer'" }
end
