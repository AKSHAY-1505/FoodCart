FactoryBot.define do
  factory :user do
    # id { 3 }
    name { 'Test Name' }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    association :role, factory: :role
  end
end
