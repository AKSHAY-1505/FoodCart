class Coupon < ApplicationRecord
  has_many :carts, dependent: :nullify
  before_destroy :remove_coupon_discount_from_carts

  validates :code, presence: true, uniqueness: true
  validates :discount, :min_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :from_date, :to_date, presence: true
  validate :valid_date_range

  private

  def valid_date_range
    return if from_date.nil? || to_date.nil?

    errors.add(:to_date, 'must be greater than from_date') if to_date < from_date
  end

  def remove_coupon_discount_from_carts
    carts.each do |cart|
      cart.discount -= discount
      cart.save
    end
  end
end
