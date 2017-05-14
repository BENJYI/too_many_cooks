class AddBalanceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :balance_in_cents, :decimal, precision: 8, scale: 2, default: 0
  end
end