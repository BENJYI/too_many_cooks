class AddImgUrlAndRatingToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :img_url, :string
    add_column :restaurants, :rating, :integer, default: 0
  end
end
