require "rails_helper"

RSpec.describe Order, type: :model do
  describe "#total_price_in_cents" do
    context "with 5 order_items, each worth $1.00 each, and each with quantity of 1" do
      it "returns 500" do
        o = FactoryGirl.create(:order)
        5.times do |i|
          mi = FactoryGirl.create(:menu_item, price_in_cents: 100)
          o.order_items.create!(menu_item: mi, order: o, quantity: 1)
        end
        expect(o.total_price_in_cents).to eql(500)
      end
    end
  end

  describe "#total_price" do
    context "with 5 order_items, each worth $1.00 each, and each with quantity of 1" do
      it "returns $5.00" do
        o = FactoryGirl.create(:order)
        5.times do |i|
          mi = FactoryGirl.create(:menu_item, price_in_cents: 100)
          o.order_items.create!(menu_item: mi, order: o, quantity: 1)
        end
        expect(o.total_price).to eql("$5.00")
      end
    end
  end
end
