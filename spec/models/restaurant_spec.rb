require "rails_helper"

RSpec.describe Restaurant, type: :model do

  describe "Geocoding" do
    # Disabling because of API limit
    # it "sets lat/lng for NYC given a NYC address" do
    #   r = FactoryGirl.create(:restaurant)
    #   r.address = "285 Fulton St, New York, NY 10007" # One World Observatory
    #   r.save!
    #   expect(r.to_coordinates).to eql([40.7130082, -74.0131689])
    # end
  end

  describe "#pretty_rating" do
    before do
      @order = FactoryGirl.create(:order)
      @restaurant = @order.restaurant
      @customer = @order.customer
      @customer.update_attribute :balance_in_cents, 20_000

      5.times do |i|
        mi = FactoryGirl.create(:menu_item, price_in_cents: 100, restaurant: @restaurant)
        @order.order_items.create!(menu_item: mi, quantity: 1)
      end

      @order.place_order
    end

    specify "sanity check!" do
      expect(@restaurant.menu_items.count).to eql(5)
      expect(@order.order_items.count).to eql(5)
      expect(@order.total_price_in_cents).to eql(500)
      expect(MenuItemFeedback.count).to eql(5)
    end

    context "all menu_item_feedbacks for restaurant have nil rating" do
      it "returns 'not-yet-rated'" do
        expect(@restaurant.pretty_rating).to eql("not-yet-rated")
      end
    end

    context "all menu_item_feedbacks have rating of 3" do
      it "returns '3-stars'" do
        MenuItemFeedback.update_all rating: 3
        expect(@restaurant.pretty_rating).to eql("3-stars")
      end
    end

    context "3 feedbacks with rating of 2, and 2 feedbacks with nil" do
      it "returns '2-stars'" do
        MenuItemFeedback.limit(3).update_all rating: 2
        expect(@restaurant.pretty_rating).to eql("2-stars")
      end
    end

    context "2 feedbacks with rating of 5, and 2 feedbacks with rating of 2, and 1 feedback with rating of nil" do
      it "returns '2-stars'" do
        feedbacks = MenuItemFeedback.all
        feedbacks[0..1].each { |f| f.update_attribute :rating, 5 }
        feedbacks[2..3].each { |f| f.update_attribute :rating, 2 }
        expect(@restaurant.pretty_rating).to eql("4-stars")
      end
    end

  end

end
