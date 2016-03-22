class AddRelationshipReferencesToSubmissions < ActiveRecord::Migration
  def change
    add_reference :submissions, :relationship, index: true, foreign_key: true
  end
end
