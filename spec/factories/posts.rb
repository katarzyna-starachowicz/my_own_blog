FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.word }
    body  { Faker::Lorem.sentence(3, true) }
  end
end
