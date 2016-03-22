class AddFilesToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :files, :string, array: true
  end
end
