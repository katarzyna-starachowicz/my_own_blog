FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.sentence(1, true) }
  end

  trait :on_post do
    commentable_type 'Post'
  end

  trait :on_comment do
    commentable_type 'Comment'
  end
end
