class Customer < User
  include ActionView::Helpers::NumberHelper
  
  validates_presence_of :address
  has_many :orders

  CENTS_IN_DOLLAR = 100

  def balance
    number_to_currency(balance_in_cents / CENTS_IN_DOLLAR)
  end
end
