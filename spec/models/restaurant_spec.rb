require "rails_helper"

RSpec.describe Restaurant, type: :model do

  describe "Geocoding" do
    it "sets lat/lng for NYC given a NYC address" do
      r = FactoryGirl.create(:restaurant)
      r.address = "285 Fulton St, New York, NY 10007" # One World Observatory
      r.save!
      expect(r.to_coordinates).to eql([40.7130082, -74.0131689])
    end
  end

end
