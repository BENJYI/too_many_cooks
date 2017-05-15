require "rails_helper"

RSpec.feature "Courier Sign In", type: :feature, driver: :selenium do
  scenario "Manager signs up and creates a courier's credentials which the courier uses to login" do

    expect(Manager.count).to eql(0)
    visit new_manager_registration_path
    fill_in "manager_name", with: "Rspec HighHo"
    fill_in "manager_email", with: "rspec@test.com"
    fill_in "manager_password", with: "password123"
    fill_in "manager_password_confirmation", with: "password123"
    click_button "Sign up"

    expect(current_path).to eql('/')
    expect(Manager.count).to eql(1)

    visit new_courier_path
    fill_in "courier_name", with: "Rspec HighHo Courier"
    fill_in "courier_email", with: "rcourier@test.com"
    fill_in "courier_password", with: "courier123"
    fill_in "courier_password_confirmation", with: "courier123"
    click_button "Create Courier"
    expect(Courier.count).to eql(1)

    visit new_courier_session_path
    fill_in "courier_email", with: "rcourier@test.com"
    fill_in "courier_password", with: "courier123"
    click_button "Log in"
  end
end