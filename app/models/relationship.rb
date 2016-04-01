class Relationship < ActiveRecord::Base
  include AASM
  belongs_to :user
  belongs_to :relation, class_name: "User"

  has_many :info_requests
  has_many :submissions

  def client
    User.find(relation_id)
  end

  def client_name
    User.find(relation_id).full_name
  end

  def consultant
    User.find(user_id)
  end

  def consultant_name
    User.find(user_id).full_name
  end

  aasm whiny_transitions: false do
    state :active, initial: true
    state :archived

    event :archive do
      transitions from: :active, to: :archived
    end
  end

  def self.active_relationships
    x = where(aasm_state: "active")
    x.map do |r|
      r.client
    end
  end

  def self.archived_relationships
    User.includes(:relationships).where(relationships: {aasm_state: "archived"})
    # where(aasm_state: "archived").includes(:users).where()
    # x.map do |r|
    #   r.client
    # end
  end
end
