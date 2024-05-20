class Food < ApplicationRecord
  acts_as_paranoid

  belongs_to :category
  has_many :order_items
  has_many :promotions, dependent: :destroy
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200], preprocessed: true
    attachable.variant :show, resize_to_limit: [800, 800], preprocessed: true
  end
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true

  before_destroy :remove_food_from_carts

  # Search query for foods
  def self.search(name)
    Food.where('name LIKE ?', "%#{name.downcase}%")
  end

  private

  # To remove food from carts when food is deleted
  def remove_food_from_carts
    OrderItem.where(food: self, ordered: false).destroy_all
  end
end
