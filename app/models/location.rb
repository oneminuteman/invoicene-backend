class Location < ApplicationRecord
  has_many :customers, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
