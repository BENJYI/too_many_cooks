class CreateMenuItemFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_item_feedbacks do |t|
      t.belongs_to :customer
      t.references :order, foreign_key: true
      t.references :menu_item, foreign_key: true
      t.text :comment
      t.integer :rating

      t.timestamps
    end

    add_index :menu_item_feedbacks, [:customer_id, :order_id, :menu_item_id], unique: true, name: "menu_item_feedbacks_unique_index"
  end
end
