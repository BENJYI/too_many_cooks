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

    context "with 5 order_items, with varying prices and quantities" do
      it "returns $7.14" do
        o = FactoryGirl.create(:order)
        o.order_items.build(
          menu_item: FactoryGirl.create(:menu_item, price_in_cents: 111),
          quantity: 1
        ).save!

        o.order_items.build(
          menu_item: FactoryGirl.create(:menu_item, price_in_cents: 111),
          quantity: 4
        ).save!

        o.order_items.build(
          menu_item: FactoryGirl.create(:menu_item, price_in_cents: 53),
          quantity: 3
        ).save!

        expect(o.total_price).to eql("$7.14")
      end
    end

  end

  describe "#place_order" do
    before do
      @order = FactoryGirl.create(:order)
      5.times do |i|
        mi = FactoryGirl.create(:menu_item, price_in_cents: 100)
        @order.order_items.create!(menu_item: mi, order: @order, quantity: 1)
      end
    end

    specify "sanity check to make sure everything is setup properly" do
      expect(@order).to be
      expect(@order.order_items.count).to eql(5)
    end

    context "Customer with balance less than total_price in cart" do
      it "should have 0 balance" do
        expect(@order.customer.balance_in_cents).to eql(0)
      end

      it "returns false" do
        expect(@order.place_order).to eql(false)
      end

      it "should not change balance" do
        @order.place_order
        expect(@order.customer.balance_in_cents).to eql(0)
      end

      it "should have status:started" do
        @order.place_order
        expect(@order.status).to eql('started')
      end

      it "should return false if the there are 0 order_items" do
        @order.order_items.destroy_all
        expect(@order.order_items.count).to eql(0)
        expect(@order.place_order).to eql(false)
      end
    end

    context "Customer with balance greater than or equal to total_price in cart" do
      before do
        @order.customer.balance_in_cents = @order.total_price_in_cents + 1000
        @order.customer.save!
      end

      it "should return the order" do
        expect(@order.place_order).to eql(true)
      end

      it "should subtract total_price from balance" do
        @order.place_order
        expect(@order.customer.balance_in_cents).to eql(1000)
      end

      it "should have status:pending" do
        @order.place_order
        expect(@order.status).to eql('pending')
      end
      
      it "should return false if the there are 0 order_items" do
        @order.order_items.destroy_all
        expect(@order.order_items.count).to eql(0)
        expect(@order.place_order).to eql(false)
      end
    end
  end
end
