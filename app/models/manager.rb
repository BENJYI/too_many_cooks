class Manager < User
  has_one :restaurant
  has_many :chefs, class_name: "Chef"
end
