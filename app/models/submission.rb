class Submission < ActiveRecord::Base
  belongs_to :info_request
  belongs_to :user
  belongs_to :relationship
  paginates_per 10

  mount_uploaders :files, FileUploader

  validates :info_request_id, uniqueness: {message: "You've already created a submission for this request."}

  def self.consultant_submissions
    Submission.all.map do |submission|
      submission if Relationship.find(submission.relationship_id).user == current_user
    end.compact
  end

  def request_category
    r = InfoRequest.find info_request_id
    r.category_name
  end

  def request_title
    r = InfoRequest.find info_request_id
    r.title
  end

  def creator
    u = User.find user_id
    u.full_name
  end

  def consultant
    relationship = Relationship.find relationship_id
    relationship.consultant_name
  end

  def content
    case request_category
    when "File"
      {files: files, notes: notes}
    when "Image"
      {files: files, notes: notes}
    when "Login"
      {username: username, email: email, notes: notes}
    when "Text"
      {text: text_content, notes: notes}
    end
  end

end
