class RemoveBodyFromSubmissions < ActiveRecord::Migration
  def change
    remove_column :submissions, :body
  end
end
