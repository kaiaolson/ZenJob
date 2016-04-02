class RemoveImagesColumnFromSubmissions < ActiveRecord::Migration
  def change
    remove_column :submissions, :images
  end
end
