class InfoRequest < ActiveRecord::Base
  has_one :submission
  belongs_to :category
  belongs_to :user

  validates :title, presence: true
  validates :relationship_id, presence: true
  validates :category_id, presence: true

  def category_name
    Category.where(id: category_id)[0].name
  end

  def creator
    u = User.find user_id
    u.full_name
  end

  def client_name
    relationship = Relationship.find relationship_id
    relationship.client_name
  end
end
