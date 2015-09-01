class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :post
      t.integer :user_id
      t.float :latitude
      t.float :longitude
      t.boolean :is_valid
      t.string :tweet_id

      t.timestamps null: false
    end
  end
end
