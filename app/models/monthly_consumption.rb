class MonthlyConsumption < ApplicationRecord
  belongs_to :customer

  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1900, less_than_or_equal_to: Time.zone.now.year }
  validates :jan, :feb, :mar, :apr, :may, :jun, :jul, :aug, :sep, :oct, :nov, :dec,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10_000 },
            allow_nil: true
end
