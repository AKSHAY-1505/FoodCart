class Food < ApplicationRecord
  belongs_to :category
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100], preprocessed: true
  end
end
