FactoryBot.define do
  factory :coupon do
    code { 'EXAMPLE100' }
    from_date { '2020-01-01' }
    to_date { '2020-01-31' }
    discount { 10 }
    min_amount { 100 }
  end
end
