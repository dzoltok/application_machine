class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.datetime :happened_at
      t.string :public_details
      t.text :private_details

      t.timestamps null: false
    end
  end
end
