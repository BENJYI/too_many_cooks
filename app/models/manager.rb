class Manager < User
  has_one :restaurant, dependent: :destroy
  has_many :chefs, class_name: "Chef", dependent: :destroy

  after_create :create_blank_restaurant

  private
    def create_blank_restaurant
      restaurant = Restaurant.new manager: self
      restaurant.save(validate: false)
    end
end
