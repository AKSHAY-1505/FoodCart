class Promotion < ApplicationRecord
  belongs_to :food
  validates :discount_percentage, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }
  validates :from_date, :to_date, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validate :valid_date_range

  def self.destroy_expired_promotions
    expired_promotions = Promotion.where('to_date < ?', Date.current)
    expired_promotions.destroy_all
  end

  private

  def valid_date_range
    return if from_date.nil? || to_date.nil?

    errors.add('To Date must be greater than From Date') if to_date < from_date
  end
end