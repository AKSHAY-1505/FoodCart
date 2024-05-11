FactoryBot.define do
  factory :food do
    name { 'Test Food' }
    price { 100 }
    description { 'Test Description' }
    quantity { 10 }
    after(:build) do |food|
      food.images.attach(io: File.open(Rails.root.to_s + '/app/assets/images/banner1.jpg'), filename: 'banner1.jpg',
                         content_type: 'image/jpg')
      food.images.attach(io: File.open(Rails.root.to_s + '/app/assets/images/banner2.jpg'), filename: 'banner2.png',
                         content_type: 'image/jpg')
    end
    association :category, factory: :category
  end
end
