class Order < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  has_one: :feedback, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :customer, class_name: "Customer", foreign_key: "customer_id" 
  belongs_to :restaurant

  enum status: [:started, :pending, :approved, :delivered]

  CENTS_IN_DOLLAR = 100

  def total_price_in_cents
    order_items.sum { |oi| oi.menu_item.price_in_cents * oi.quantity }
  end

  def total_price
    number_to_currency(total_price_in_cents / CENTS_IN_DOLLAR)
  end

  def place_order
    new_balance = self.customer.balance_in_cents - self.total_price_in_cents
    return false if order_items.count == 0 || new_balance < 0
    self.customer.balance_in_cents = new_balance
    self.customer.save
    self.pending!
    self.save
  end
end