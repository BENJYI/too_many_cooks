require "rails_helper"

RSpec.describe MenuItem, type: :model do

  describe "#price" do
    it "returns 0 when price_in_cents is 0" do
      mi = FactoryGirl.create(:menu_item, price_in_cents: 0)
      expect(mi.price_in_cents).to eql(0)
      expect(mi.price).to eql("$0.00")
    end

    it "returns $1.00 when price_in_cents is 100" do
      mi = FactoryGirl.create(:menu_item, price_in_cents: 100)
      expect(mi.price_in_cents).to eql(100)
      expect(mi.price).to eql("$1.00")
    end
  end

end
