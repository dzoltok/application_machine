class AddAasmStateToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :aasm_state, :string
  end
end
