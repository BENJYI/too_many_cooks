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
  address: "6926 5th ave Brooklyn, NY 11209",
  balance_in_cents: 999999
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
    chef = m.chefs.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "password",
      password_confirmation: "password"
    )

    5.times do |i|
      m.restaurant.menu_items.create!(
        name: Faker::Beer.name,
        price_in_cents: rand(150) + 1,
        chef: chef
      )
    end

  end

  2.times do |j|
    m.couriers.create!(
      name: Faker::Name.name,
      email: "courier#{i}#{j}@test.com",
      password: "password",
      password_confirmation: "password"
    )
  end

    3.times do |i|
    o1 = m.restaurant.orders.create!(status: :pending, customer: customer)
    o2 = m.restaurant.orders.create!(status: :approved, customer: customer)
    o3 = m.restaurant.orders.create!(status: :delivered, customer: customer)

    [o1, o2, o3].each do |order|
      3.times { order.add_item!(menu_item_id: order.restaurant.menu_items.sample.id, quantity: (rand(7) + 1)) }
      order.place_order
    end
  end
end