class Submission < ActiveRecord::Base
  belongs_to :info_request
  belongs_to :user

  mount_uploaders :images, ImageUploader
  mount_uploaders :files, FileUploader

  validates :info_request_id, uniqueness: {message: "You've already created a submission for this request."}

  def self.pending_count
    where(completed: false).count
  end

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

  def content
    case request_category
    when "File"
      {files: files}
    when "Image"
      {images: ""}
    when "Login"
      {username: username, email: email}
    when "Text"
      {text: text_content}
    end
  end

end
