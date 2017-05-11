FactoryGirl.define do

  factory :user do
    name      { Faker::Name.name }
    email     { Faker::Internet.email }
    password  "password"
  end

  factory :manager do
    name      { Faker::Name.name }
    email     { Faker::Internet.email }
    password  "password"
    type      "Manager"
  end

  factory :chef do
    name      { Faker::Name.name }
    email     { Faker::Internet.email }
    password  "password"
    type      "Chef"
  end

  factory :restaurant do
    name      { Faker::Company.name }
  end

end
