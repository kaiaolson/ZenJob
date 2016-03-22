class CreateInfoRequests < ActiveRecord::Migration
  def change
    create_table :info_requests do |t|
      t.string :title
      t.text :description
      t.text :requirements
      t.references :category, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :completed, default: false

      t.timestamps null: false
    end
    add_index :info_requests, :completed
  end
end
