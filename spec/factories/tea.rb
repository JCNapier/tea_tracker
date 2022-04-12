FactoryBot.define do 
  factory :tea do 
    association :subscription, factory: :subscription
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.between(from: 100, to: 120) }
    brew_time { Faker::Number.between(from: 3, to: 10) }
  end
end