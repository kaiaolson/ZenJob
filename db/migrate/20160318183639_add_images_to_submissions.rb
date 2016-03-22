class AddImagesToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :images, :string, array: true
  end
end
