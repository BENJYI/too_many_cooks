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
  end
end