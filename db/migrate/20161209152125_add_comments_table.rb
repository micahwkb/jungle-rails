class AddCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments do |c|
      c.text :content
      c.integer :product_id, references: :products
    end
  end
end
