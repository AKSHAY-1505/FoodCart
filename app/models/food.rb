class Food < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :promotions, dependent: :destroy
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200], preprocessed: true
    attachable.variant :show, resize_to_limit: [800, 800], preprocessed: true
  end
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
end
