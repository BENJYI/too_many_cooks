require "rails_helper"

RSpec.describe Customer, type: :model do
  specify "sanity check for making sure #type is set correctly for Customer with type :customer" do
    c = Customer.create email: "rspec@test.com", password: "password"
    expect(c).to be
    expect(c.class).to eql(Customer)
  end

  describe "Geocoding" do
    it "sets lat/lng for NYC given a NYC address" do
      u = FactoryGirl.create(:customer)
      u.address = "285 Fulton St, New York, NY 10007" # One World Observatory
      u.save!
      expect(u.to_coordinates).to eql([40.7130082, -74.0131689])
    end
  end
end
