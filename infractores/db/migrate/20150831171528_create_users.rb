class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account_id
      t.string :account_name

      t.timestamps null: false
    end
  end
end
