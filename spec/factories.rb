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

  factory :restaurant do
    name      { Faker::Company.name }
    address   { Faker::Address.street_address }
  end

  factory :menu_item do
    association :restaurant
    name      { Faker::Company.name }
    price_in_cents     { 100 }
  end

end
