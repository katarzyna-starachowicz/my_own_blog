FactoryGirl.define do
  factory :comment do
    body             { Faker::Lorem.sentence(1, true) }
    commentator_name { Faker::Lorem.word }
  end
end
