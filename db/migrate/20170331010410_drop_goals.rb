class DropGoals < ActiveRecord::Migration
  def up
    drop_table :goals
  end

  def down
    create_table :goals do |t|
      t.string :goal_type
      t.belongs_to :user, index: true, foreign_key: true
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
