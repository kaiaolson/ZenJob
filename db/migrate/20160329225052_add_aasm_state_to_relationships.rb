class AddAasmStateToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :aasm_state, :string, index: true
  end
end
