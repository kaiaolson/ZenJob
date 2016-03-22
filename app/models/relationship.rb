class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :relation, class_name: "User"

  def client_name
    User.find(relation_id).full_name
  end

  def consultant_name
    User.find(user_id).full_name
  end
end
