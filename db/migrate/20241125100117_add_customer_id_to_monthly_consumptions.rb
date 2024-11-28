class AddCustomerIdToMonthlyConsumptions < ActiveRecord::Migration[8.0]
  def change
    add_column :monthly_consumptions, :customer_id, :integer
    add_index :monthly_consumptions, :customer_id
  end
end
