class AddRelationshipReferencesToInfoRequests < ActiveRecord::Migration
  def change
    add_reference :info_requests, :relationship, index: true, foreign_key: true
  end
end
