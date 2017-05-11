class Manager < User
  has_many :chefs, class_name: "Chef"
end
