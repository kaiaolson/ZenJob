FactoryGirl.define do
  factory :team do
    name        { Faker::Name.name }
    company     { Faker::Company.name }
    description { Faker::Lorem.sentence }
  end
end
