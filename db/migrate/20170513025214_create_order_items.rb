class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.belongs_to :menu_item
      t.belongs_to :order
      t.timestamps
    end
  end
end
