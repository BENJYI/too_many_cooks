require "rails_helper"

RSpec.feature "Chef Sign In", type: :feature, driver: :selenium do
  scenario "Manager signs up and creates a chef's credentials which the chef uses to login" do

    expect(Manager.count).to eql(0)
    visit new_manager_registration_path
    fill_in "manager_name", with: "Rspec HighHo"
    fill_in "manager_email", with: "rspec@test.com"
    fill_in "manager_password", with: "password123"
    fill_in "manager_password_confirmation", with: "password123"
    click_button "Sign up"

    expect(current_path).to eql('/')
    expect(Manager.count).to eql(1)

    visit new_chef_path
    fill_in "chef_name", with: "Rspec HighHo Chef"
    fill_in "chef_email", with: "rchef@test.com"
    fill_in "chef_password", with: "chef123"
    fill_in "chef_password_confirmation", with: "chef123"
    click_button "Create Chef"
    expect(Chef.count).to eql(1)

    visit new_chef_session_path
    fill_in "chef_email", with: "rchef@test.com"
    fill_in "chef_password", with: "chef123"
    click_button "Log in"
  end
end