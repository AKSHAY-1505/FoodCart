json.extract! food, :id, :name, :description, :price, :quantity, :category_id, :images, :created_at, :updated_at
json.url food_url(food, format: :json)
json.images do
  json.array!(food.images) do |image|
    json.id image.id
    json.url url_for(image)
  end
end
