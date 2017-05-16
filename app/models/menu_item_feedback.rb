class MenuItemFeedback < ApplicationRecord
  belongs_to :customer
  belongs_to :order
  belongs_to :menu_item

  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :order_id, uniqueness: { scope: [:customer_id, :menu_item_id, :order_id] }
end
