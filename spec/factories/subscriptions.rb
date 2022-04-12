FactoryBot.define do 
  factory :subscription do 
    title { Faker::Games::ClashOfClans.rank }
    price { Faker::Number.decimal(l_digits: 2) }
    status { [0, 1].sample }
    frequency { ['high', 'medium', 'low'].sample }
  end
end