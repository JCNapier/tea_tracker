FactoryBot.define do 
  factory :customer_subscription do 
    association :customer, factory: :customer
    association :subscription, factory: :subscription
  end
end