FactoryGirl.define do
  factory :info_request do
    association :user, factory: :user
    association :category, factory: :category

    title         { Faker::Company.bs }
    description   { Faker::Lorem.paragraph }
    requirements  { Faker::Lorem.paragraph }
  end
end
