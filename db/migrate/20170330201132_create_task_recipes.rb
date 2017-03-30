class CreateTaskRecipes < ActiveRecord::Migration
  def change
    create_table :task_recipes do |t|
      t.string :event
      t.text :description
      t.integer :days_before_due
      t.string :category_name

      t.timestamps null: false
    end
  end
end
