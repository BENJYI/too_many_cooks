require "rails_helper"

RSpec.feature "Chef Sign Up", type: :feature, driver: :selenium do
  scenario "Chef signs up usingn the default devise form" do

    expect(Chef.count).to eql(0)
    visit new_chef_registration_path
    fill_in "chef_email", with: "rspec@test.com"
    fill_in "chef_password", with: "password123"
    fill_in "chef_password_confirmation", with: "password123"
    click_button "Sign up"

    expect(current_path).to eql('/')
    expect(Chef.count).to eql(1)

    # Should be able to access the protected user routes
    visit "/chefs/example_protected_route"
    expect(page).to have_content("chefs/application_controller#example_protected_route is working")

    # The other protected routes should *not* be accessible though
    visit "/users/example_protected_route"
    expect(page).to have_content("Log in -  User")
    expect(page).to_not have_content("users/application_controller#example_protected_route is working")

    visit "/managers/example_protected_route"
    expect(page).to have_content("Log in -  Manager")
    expect(page).to_not have_content("managers/application_controller#example_protected_route is working")

  end
end