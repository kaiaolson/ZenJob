FactoryGirl.define do
  factory :category do
    title { Faker::Commerce.department(1, true) }
  end
end
