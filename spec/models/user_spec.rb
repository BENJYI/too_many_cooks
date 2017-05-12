require "rails_helper"

RSpec.describe User, type: :model do
  specify "sanity check for making sure #type is set correctly for User with type :user" do
    u = User.create email: "rspec@test.com", password: "password"
    expect(u).to be
    expect(u.class).to eql(User)
    expect(u.type).to eql(nil)
  end

  describe "Geocoding" do
    it "sets lat/lng for NYC given a NYC address" do
      u = FactoryGirl.create(:user)
      u.address = "285 Fulton St, New York, NY 10007" # One World Observatory
      u.save!
      expect(u.to_coordinates).to eql([40.7130082, -74.0131689])
    end
  end
end
