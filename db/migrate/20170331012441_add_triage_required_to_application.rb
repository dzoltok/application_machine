class AddTriageRequiredToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :triage_required, :boolean
  end
end
