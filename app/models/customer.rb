class Customer < User
  include ActionView::Helpers::NumberHelper
  
  validates_presence_of :address
  has_many :orders
  has_many :menu_item_feedbacks

  CENTS_IN_DOLLAR = 100

  def balance
    number_to_currency(balance_in_cents / CENTS_IN_DOLLAR)
  end

  def feedbacks(order_item:)
    MenuItemFeedback.find_by({
      customer: self,
      order: order_item.order,
      menu_item: order_item.menu_item
    })
  end
end
