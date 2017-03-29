class AddAasmStateToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :aasm_state, :string
  end
end
