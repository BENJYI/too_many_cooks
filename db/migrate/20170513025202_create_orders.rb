class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :status
      t.belongs_to :customer
      t.belongs_to :restaurant
      t.timestamps
    end
  end
end
