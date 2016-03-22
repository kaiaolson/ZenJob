class AddInfoRequestReferencesToSubmissions < ActiveRecord::Migration
  def change
    add_reference :submissions, :info_request, index: true, foreign_key: true
  end
end
