class AddSubmissionFieldsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :text_content, :text
    add_column :submissions, :username, :string
    add_column :submissions, :email, :string
  end
end
