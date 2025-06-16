# app/models/user.rb
class User < ApplicationRecord
  has_secure_password # This macro provides authentication methods

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, on: :create # `on: :create` means it's validated only on new record creation
  validates :password_confirmation, presence: true, on: :create
end
