class Customer < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :house_number, presence: true
  validates :street, presence: true
  validates :locality, presence: true
  validates :city, presence: true
  validates :phone_number, presence: true
  validates :phone_number, length: {is: 10, message: "must be 10 digits!"}



end
