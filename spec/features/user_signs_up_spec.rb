require "rails_helper"

RSpec.feature "User Sign Up", type: :feature, driver: :selenium do
  scenario "User signs up usingn the default devise form" do

    expect(User.count).to eql(0)
    visit new_user_registration_path
    fill_in "user_email", with: "rspec@test.com"
    fill_in "user_password", with: "password123"
    fill_in "user_password_confirmation", with: "password123"
    click_button "Sign up"

    expect(current_path).to eql('/')
    expect(User.count).to eql(1)

    # Should be able to access the protected user routes
    visit "/users/example_protected_route"
    expect(page).to have_content("users/application_controller#example_protected_route is working")

    # The other protected routes should *not* be accessible though
    visit "/chefs/example_protected_route"
    expect(page).to_not have_content("chefs/application_controller#example_protected_route is working")

    visit "/managers/example_protected_route"
    expect(page).to_not have_content("managers/application_controller#example_protected_route is working")

  end
end