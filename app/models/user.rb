class User < ActiveRecord::Base
  has_secure_password
  acts_as_messageable
  before_create :generate_api_key

  has_many :info_requests
  has_many :submissions

  has_many :relationships
  has_many :clients, through: :relationships, source: :relation
  has_many :inverse_relationships, class_name: "Relationship", foreign_key: "relation_id"
  has_many :consultants, through: :inverse_relationships, source: :user

  has_many :team_memberships, dependent: :nullify
  has_many :teams, through: :team_memberships

  validates :password, presence: true, length: {minimum: 6}, on: :create
  validates :first_name, presence: true, on: :create
  validates :last_name, presence: true, on: :create
  validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name} #{last_name}"
  end

  def mailboxer_email(object)
    #Check if an email should be sent for that object
    #if true
    email
    #if false
    #return nil
  end

  def client_names
    clients.map do |client|
      client.full_name
    end
  end

  def consultant?
    role == "consultant"
  end

  def client?
    role == "client"
  end

  def self.info_requests(user)
    r = Relationship.where(relation: user)
    InfoRequest.where(relationship_id: r.first.id).order(:id) unless r.first.nil?
  end

  def pending_requests_count
    if consultant?
      info_requests.where(completed: false).count
    else
      User.info_requests(self) ? (User.info_requests(self).where(completed: false).count) : 0
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(32)
    while User.exists?(api_key: self.api_key)
      self.api_key = SecureRandom.hex(32)
    end
  end
end
