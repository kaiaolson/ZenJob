FactoryGirl.define do
  factory :submission do
    association :user, factory: :user
    association :request, factory: :request

    body  { Faker::Lorem.paragraph }
    notes { Faker::Lorem.paragraph }
  end
end
