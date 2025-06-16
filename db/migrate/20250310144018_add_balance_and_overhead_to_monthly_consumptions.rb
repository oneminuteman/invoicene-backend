class AddBalanceAndOverheadToMonthlyConsumptions < ActiveRecord::Migration[7.0]
  def change
    add_column :monthly_consumptions, :balance, :decimal, precision: 10, scale: 2, default: nil
    add_column :monthly_consumptions, :overhead, :decimal, precision: 10, scale: 2, default: nil
  end
end

