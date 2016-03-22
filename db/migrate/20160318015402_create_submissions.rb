class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :body
      t.text :notes
      t.boolean :completed, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :submissions, :completed
  end
end
