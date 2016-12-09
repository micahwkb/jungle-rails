class AddRatingsTable < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :product_id
      t.integer :user_id
      t.text :description
      t.integer :rating
      t.timestamps null: false
    end
    add_index :ratings, :product_id
    add_index :ratings, :user_id
  end
end
