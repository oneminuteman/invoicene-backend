class CreateMonthlyConsumptions < ActiveRecord::Migration[6.1]
  def change
    create_table :monthly_consumptions do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :year, null: false
      t.decimal :jan, precision: 10, scale: 2, default: 0.0
      t.decimal :feb, precision: 10, scale: 2, default: 0.0
      t.decimal :mar, precision: 10, scale: 2, default: 0.0
      t.decimal :apr, precision: 10, scale: 2, default: 0.0
      t.decimal :may, precision: 10, scale: 2, default: 0.0
      t.decimal :jun, precision: 10, scale: 2, default: 0.0
      t.decimal :jul, precision: 10, scale: 2, default: 0.0
      t.decimal :aug, precision: 10, scale: 2, default: 0.0
      t.decimal :sep, precision: 10, scale: 2, default: 0.0
      t.decimal :oct, precision: 10, scale: 2, default: 0.0
      t.decimal :nov, precision: 10, scale: 2, default: 0.0
      t.decimal :dec, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end

