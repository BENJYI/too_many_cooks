class AddChefIdToMenuItems < ActiveRecord::Migration[5.1]
  def change
    add_column :menu_items, :chef_id, :bigint
    add_index :menu_items, :chef_id
  end
end
