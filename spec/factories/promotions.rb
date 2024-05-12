FactoryBot.define do
  factory :promotion do
    title { 'Example Promotion' }
    description { 'Example Description' }
    from_date { '2020-01-01' }
    to_date { '2020-01-31' }
    discount_percentage { 10 }
    association :food, factory: :food
  end
end
