class Customer < ApplicationRecord
  belongs_to :location
  has_many :monthly_consumptions, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :location_id, message: "should be unique within a location" }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, format: { with: /\A[0-9]{10,15}\z/, message: "must be a valid phone number (10-15 digits)" }
end


