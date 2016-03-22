FactoryGirl.define do
  factory :relationship do
    association :user, factory: :user
    association :relation, factory: :user
  end
end
