class Food < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200], preprocessed: true
    attachable.variant :show, resize_to_limit: [800, 800], preprocessed: true
  end
end
