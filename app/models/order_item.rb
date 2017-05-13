class OrderItem < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  CENTS_IN_DOLLAR = 100

  belongs_to :menu_item
  belongs_to :order

  def total_price
    number_to_currency(menu_item.price_in_cents / CENTS_IN_DOLLAR * quantity)
  end
end
