class Order < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  has_many :order_items, dependent: :destroy
  has_many :menu_item_feedbacks
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

  def add_item!(order_item_params)
    # If order_item is already in the cart, just increment the quantity
    if(order_item=self.order_items.find_by menu_item_id: order_item_params[:menu_item_id]).present?
      order_item.update(quantity: (order_item.quantity + order_item_params[:quantity].to_i))
    else
      self.order_items.build(order_item_params)
    end

    self.save!
  end

  def place_order
    new_balance = self.customer.balance_in_cents - self.total_price_in_cents
    return false if order_items.count == 0 || new_balance < 0
    self.customer.balance_in_cents = new_balance
    self.customer.save
    self.pending!

    self.order_items.each do |order_item|
      mif = MenuItemFeedback.new({
        customer: self.customer,
        order: self,
        menu_item: order_item.menu_item
      })
      mif.save(validate: false)
    end

    self.save
  end

end