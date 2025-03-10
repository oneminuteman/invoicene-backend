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

  # Ensure either balance or overhead is set, but not both
  validate :only_one_financial_value_set

  private

  def only_one_financial_value_set
    balance_value = balance.to_f
    overhead_value = overhead.to_f

    Rails.logger.debug "DEBUG: Balance = #{balance_value}, Overhead = #{overhead_value}"

    if balance_value > 0 && overhead_value > 0
      Rails.logger.debug "❌ ERROR: Both balance and overhead are set!"
      errors.add(:base, "Cannot have both balance and overhead at the same time.")
    end
  end
end


