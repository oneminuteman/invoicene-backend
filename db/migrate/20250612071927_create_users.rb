# db/migrate/XXXXXXXXXXXXXX_create_users.rb (The XXXXXXXXXXXXXX will be a timestamp)
class CreateUsers < ActiveRecord::Migration[7.0] # Adjust version if different
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest # Crucial for has_secure_password

      t.timestamps
    end
    add_index :users, :email, unique: true # Ensure emails are unique
  end
end
