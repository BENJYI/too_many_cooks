class MenuItem < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  CENTS_IN_DOLLAR = 100

  belongs_to :restaurant
  
  validates_presence_of :name, :price_in_cents

  def price
    number_to_currency(price_in_cents / CENTS_IN_DOLLAR)
  end

end
