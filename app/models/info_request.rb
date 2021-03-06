class InfoRequest < ActiveRecord::Base
  has_one :submission, dependent: :destroy
  belongs_to :category
  belongs_to :user
  belongs_to :relationship
  paginates_per 10

  # scope :scope_date, -> { order(created_at: :desc) }

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

  def content
    {"Client": client_name,
      "Consultant": creator,
      "Category": category_name,
      "Description": description,
      "Requirements": requirements}
  end

  def priority_label
    case priority
    when 1
      "High"
    when 2
      "Medium"
    when 3
      "Low"
    end
  end

  def category_label
    case category_name
    when "Text"
      "Text"
    when "Image"
      "Image"
    when "Login"
      "Login"
    when "File"
      "File"
    end
  end
end
