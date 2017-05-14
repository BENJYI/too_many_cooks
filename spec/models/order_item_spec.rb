require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  describe "Callbacks" do
    context "#afer_validation" do

      before do
        @oi = FactoryGirl.create :order_item
      end

      specify "(sanity check) raises validation error if quantity is a negative number" do
        expect(@oi.persisted?).to eql(true)
        @oi.quantity = -3
        expect{ @oi.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Quantity must be greater than or equal to 0")
      end

      it "should be destroyed if quantity is 0" do
        @oi.quantity = 0
        @oi.save!
        expect(OrderItem.exists?(@oi.id)).to eql(false)
      end

      it "should be not be destroyed if quantity is 3" do
        @oi.quantity = 3
        expect{ @oi.save! }.to_not change{ OrderItem.count }
        expect(OrderItem.exists?(@oi.id)).to eql(true)
      end

    end
  end
end
