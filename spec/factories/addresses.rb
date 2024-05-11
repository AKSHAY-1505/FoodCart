FactoryBot.define do
  factory :address do
    house_number { '123' }
    street_name { 'Test Street' }
    locality { 'Test Locality' }
    city { 'Test City' }
    phone_number { '1234567890' }
    association :user, factory: :user
  end
end
