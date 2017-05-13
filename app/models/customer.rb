class Customer < User
  validates_presence_of :address
  has_many :orders
end
