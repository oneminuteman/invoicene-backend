class CreateMonthlyConsumptions < ActiveRecord::Migration[8.0]
  def change
    create_table :monthly_consumptions do |t|
      t.integer :year
      t.decimal :jan
      t.decimal :feb
      t.decimal :mar
      t.decimal :apr
      t.decimal :may
      t.decimal :jun
      t.decimal :jul
      t.decimal :aug
      t.decimal :sep
      t.decimal :oct
      t.decimal :nov
      t.decimal :dec

      t.timestamps
    end
  end
end
