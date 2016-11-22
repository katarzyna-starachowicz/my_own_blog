FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.sentence(1, true) }
  end
end
