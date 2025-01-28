class UpdateMonthlyConsumptionsToAllowYears < ActiveRecord::Migration[6.1]
  def change
    # Remove month-specific columns
    remove_column :monthly_consumptions, :jan, :integer
    remove_column :monthly_consumptions, :feb, :integer
    remove_column :monthly_consumptions, :mar, :integer
    remove_column :monthly_consumptions, :apr, :integer
    remove_column :monthly_consumptions, :may, :integer
    remove_column :monthly_consumptions, :jun, :integer
    remove_column :monthly_consumptions, :jul, :integer
    remove_column :monthly_consumptions, :aug, :integer
    remove_column :monthly_consumptions, :sep, :integer
    remove_column :monthly_consumptions, :oct, :integer
    remove_column :monthly_consumptions, :nov, :integer
    remove_column :monthly_consumptions, :dec, :integer

    # Add month and consumption columns
    add_column :monthly_consumptions, :month, :string
    add_column :monthly_consumptions, :consumption, :integer
  end
end

