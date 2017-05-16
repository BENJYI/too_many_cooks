# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seeding managers

MenuItemFeedback.destroy_all
MenuItem.destroy_all
Manager.destroy_all

customer = Customer.create!(
  name: Faker::Name.name,
  email: Faker::Internet.email, 
  password: "password", 
  password_confirmation: "password",
  address: "6926 5th ave Brooklyn, NY 11209"
)

20.times do |i|
  m = Manager.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email, 
    password: "password", 
    password_confirmation: "password"
  )
  m.restaurant.name = Faker::Company.name;
  m.restaurant.address = Faker::Address.street_address;
  m.restaurant.save!;

  2.times do |i|
    m.chefs.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email, 
      password: "password", 
      password_confirmation: "password"
    )
  end

  2.times do |j|
    m.couriers.create!(
      name: Faker::Name.name,
      email: "courier#{i}#{j}@test.com", 
      password: "password", 
      password_confirmation: "password"
    )
  end

  10.times do |i|
    m.restaurant.menu_items.create!(
      name: Faker::Beer.name,
      price_in_cents: rand(150) + 1
    )
  end

  3.times do |i|
    m.restaurant.orders.create!(status: :pending, customer: customer)
    m.restaurant.orders.create!(status: :approved, customer: customer)
    m.restaurant.orders.create!(status: :delivered, customer: customer)
  end  
end