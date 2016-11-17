FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.safe_email }
    password { Faker::Internet.password }
  end

  trait :admin do
    admin true
  end
end
