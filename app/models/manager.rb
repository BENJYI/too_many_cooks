class Manager < User
  has_one :restaurant
  has_many :chefs, class_name: "Chef"

  after_create :create_blank_restaurant

  private
    def create_blank_restaurant
      Restaurant.create! manager: self
    end
end
