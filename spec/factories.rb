FactoryGirl.define do

  factory :customer do
    name      { Faker::Name.name }
    email     { Faker::Internet.email }
    address   { Faker::Address.street_address }
    password  "password"
  end

  factory :manager do
    name      { Faker::Name.name }
    email     { Faker::Internet.email }
    address   { Faker::Address.street_address }
    password  "password"
    type      "Manager"
  end

  factory :chef do
    name      { Faker::Name.name }
    email     { Faker::Internet.email }
    address   { Faker::Address.street_address }
    password  "password"
    type      "Chef"
  end

  factory :courier do
    name      { Faker::Name.name }
    email     { Faker::Internet.email }
    address   { Faker::Address.street_address }
    password  "password"
    type      "Courier"
  end

  factory :restaurant do
    name      { Faker::Company.name }
    address   { Faker::Address.street_address }
  end

  factory :menu_item do
    association :restaurant
    association :chef
    name      { Faker::Company.name }
    price_in_cents     { 100 }
  end

  factory :order do
    association :restaurant
    association :customer
  end

  factory :order_item do
    association :menu_item
    association :order
    quantity 1
  end

end
