require "rails_helper"

RSpec.feature "Customer Sign Up", type: :feature, driver: :selenium do
  scenario "Customer signs up usingn the default devise form" do

    expect(Customer.count).to eql(0)
    visit new_customer_registration_path
    fill_in "customer_name", with: "LeBron James"
    fill_in "customer_address", with: "123 Park Place"
    fill_in "customer_email", with: "rspec@test.com"
    fill_in "customer_password", with: "password123"
    fill_in "customer_password_confirmation", with: "password123"
    click_button "Sign up"

    expect(current_path).to eql('/')
    expect(Customer.count).to eql(1)

    # Should be able to access the protected customer routes
    visit "/customers/example_protected_route"
    expect(page).to have_content("customers/application_controller#example_protected_route is working")

    # The other protected routes should *not* be accessible though
    visit "/chefs/example_protected_route"
    expect(page).to have_content("Log in -  Chef")
    expect(page).to_not have_content("chefs/application_controller#example_protected_route is working")

    visit "/managers/example_protected_route"
    expect(page).to have_content("Log in -  Manager")
    expect(page).to_not have_content("managers/application_controller#example_protected_route is working")

  end
end