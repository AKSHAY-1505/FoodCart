FactoryBot.define do
  factory :order_delivery_agent do
    assigned_at { Time.now }
    association :order, factory: :order
    association :user, factory: :user
  end
end
