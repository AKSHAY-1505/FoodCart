class Food < ApplicationRecord
  belongs_to :category
  has_many_attached :images
end