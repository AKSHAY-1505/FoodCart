class Address < ApplicationRecord
  belongs_to :customer

  validates :house_number, presence: true
  validates :street_name, presence: true
  validates :locality, presence: true
  validates :city, presence: true
  validates :phone_number, presence: true
  validates :phone_number, length: { is: 10, message: 'must be 10 digits!' }
end
