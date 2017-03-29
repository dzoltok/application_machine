class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :description
      t.string :assigned_to
      t.datetime :due_at

      t.timestamps null: false
    end
    add_index :tasks, :assigned_to
  end
end
