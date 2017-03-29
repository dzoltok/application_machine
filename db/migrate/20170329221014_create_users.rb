class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email_address, null: false

      t.timestamps null: false
    end
  end
end
