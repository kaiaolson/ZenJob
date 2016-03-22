FactoryGirl.define do
  factory :team_membership do
    association :user, factory: :user
    association :team, factory: :team

    team_admin  false
  end
end
