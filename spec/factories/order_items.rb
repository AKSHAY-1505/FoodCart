FactoryBot.define do
  factory :order_item do
    association :order, factory: :order
    association :food, factory: :food
    association :user, factory: :user
    quantity { 1 }
    ordered { true }
    subtotal { 1000 }
    discount { 0 }
  end
end
