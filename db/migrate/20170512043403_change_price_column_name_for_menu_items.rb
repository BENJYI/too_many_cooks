class ChangePriceColumnNameForMenuItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :menu_items, :price

    # precision is the total number of digits
    # scale is the number of digits to the right of the decimal point
    add_column    :menu_items, :price_in_cents, :decimal, precision: 8, scale: 2
  end
end
