class AddPriorityColumnToInfoRequests < ActiveRecord::Migration
  def change
    add_column :info_requests, :priority, :integer, default: 3
  end
end
