FactoryBot.define do
  factory :order do
    subtotal { 1000 }
    delivery_charge { 0 }
    discount { 100 }
    total { 950 }
    status { :order_placed }
    is_active { true }
    association :user, factory: :user
    association :address, factory: :address
  end
end
