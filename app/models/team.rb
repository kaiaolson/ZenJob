class Team < ActiveRecord::Base
  has_many :team_memberships, dependent: :nullify
  has_many :users, through: :team_memberships
end
