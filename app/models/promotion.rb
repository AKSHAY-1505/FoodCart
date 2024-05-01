class Promotion < ApplicationRecord
  belongs_to :food

  def self.destroy_expired_promotions
    expired_promotions = Promotion.where('to_date < ?', Date.current)
    expired_promotions.destroy_all
  end
end
