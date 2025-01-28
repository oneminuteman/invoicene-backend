class Customer < ApplicationRecord
  # Associations
  belongs_to :location
  has_many :monthly_consumptions, dependent: :destroy

  # Validations
  validates :name, presence: true, 
                   uniqueness: { scope: :location_id, 
                                 message: "should be unique within a location" }

  # Nested Attributes
  accepts_nested_attributes_for :monthly_consumptions, allow_destroy: true

  # Optional: Callbacks (if needed for additional logic)
  # before_save :normalize_name
  #
  # private
  # def normalize_name
  #   self.name = name.strip.titleize
  # end
end



