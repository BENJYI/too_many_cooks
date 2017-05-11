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
  end
end