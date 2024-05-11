FactoryBot.define do
  factory :user do
    name { 'Test Name' }
    email { 'test@mail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    association :role, factory: :role
  end
end
