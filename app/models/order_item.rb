class OrderItem < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  CENTS_IN_DOLLAR = 100

  belongs_to :menu_item
  belongs_to :order

  after_save :destroy_if_necessary
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def total_price
    number_to_currency(menu_item.price_in_cents / CENTS_IN_DOLLAR * quantity)
  end

  private
    def destroy_if_necessary
      self.destroy unless quantity > 0
    end
end
