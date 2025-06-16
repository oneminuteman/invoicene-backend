# app/models/customer.rb
class Customer < ApplicationRecord
  # Associations
  # A customer belongs to one location. If the location is deleted,
  # dependent customers will also be handled (e.g., destroyed).
  belongs_to :location

  # A customer can have many monthly consumptions. If the customer is deleted,
  # all associated monthly consumptions will also be destroyed.
  has_many :monthly_consumptions, dependent: :destroy

  # Validations
  # Ensures that a customer's name is present (not empty).
  # Ensures that the customer's name is unique within the scope of a specific location.
  # This prevents having two customers with the exact same name in the same location.
  validates :name, presence: true,
                   uniqueness: { scope: :location_id,
                                 message: "should be unique within a location" }

  # Nested Attributes
  # Allows you to create, update, and destroy associated monthly_consumptions
  # directly through the customer object, using nested parameters.
  # `allow_destroy: true` enables the deletion of nested records.
  accepts_nested_attributes_for :monthly_consumptions, allow_destroy: true

  # Optional: Callbacks (if needed for additional logic)
  # You can uncomment and modify these if you need to add pre-save or post-save logic.
  # For example, normalizing the customer's name before saving.
  #
  # before_save :normalize_name
  #
  # private
  # def normalize_name
  #   self.name = name.strip.titleize if name.present?
  # end
end