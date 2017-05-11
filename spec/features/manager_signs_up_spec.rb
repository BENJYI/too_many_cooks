require "rails_helper"

RSpec.feature "Manager Sign Up", type: :feature, driver: :selenium do
  scenario "Manager signs up usingn the default devise form" do

    expect(Manager.count).to eql(0)
    visit new_manager_registration_path
    fill_in "manager_email", with: "rspec@test.com"
    fill_in "manager_password", with: "password123"
    fill_in "manager_password_confirmation", with: "password123"
    click_button "Sign up"

    expect(current_path).to eql('/')
    expect(Manager.count).to eql(1)
  end
end