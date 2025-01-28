class MonthlyConsumption < ApplicationRecord
  belongs_to :customer

  # Validations
  validates :year, presence: true, 
                   numericality: { 
                     only_integer: true, 
                     greater_than_or_equal_to: 1900, 
                     less_than_or_equal_to: Time.zone.now.year 
                   }
  validates :month, presence: true, 
                    inclusion: { in: Date::MONTHNAMES.compact, 
                                 message: "must be a valid month name" }
  validates :consumption, presence: true, 
                          numericality: { 
                            greater_than_or_equal_to: 0, 
                            less_than_or_equal_to: 10_000, 
                            message: "must be between 0 and 10,000" 
                          }
end

