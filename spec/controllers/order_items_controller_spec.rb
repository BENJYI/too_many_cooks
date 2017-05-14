require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do

  before do
    @restaurant = FactoryGirl.create(:restaurant)
    3.times { |i| FactoryGirl.create(:menu_item, price_in_cents: (1000 * i), restaurant: @restaurant) }
  end

  specify "sanity check" do
    expect(@restaurant).to be
    expect(@restaurant.menu_items.count).to eql(3)
  end

  context "without customer signed_in" do
    it "should not have a current_customer" do
      expect(controller.current_customer).to be_nil
    end

    it "current_order should be blank order oject" do
      expect(controller.current_order ).to be
      expect(controller.current_order.persisted?).to eql(false)
    end
  end

  context "with custom signed_in" do
    before do
      @customer = FactoryGirl.create(:customer)
      sign_in @customer
    end

    it "current_order should be blank order oject" do
      expect(controller.current_customer).to eql(@customer)
      expect(controller.current_order).to be
      expect(controller.current_order.persisted?).to eql(false)
    end
  end

  describe "POST #create" do

    # TODO: Test this in integration spec
    # it "redirects customer to log_in page if current_customer is blank" do
    #   expect(Order.count).to eql(0)
    #   post :create
    #   expect(response).to have_http_status(:found) #302
    #   expect(response).to redirect_to(new_customer_session_path)
    #   expect(Order.count).to eql(0)
    # end

    context "with valid parameters" do
      it "creates a new order and adds the correct order_item to the order" do
        @customer = FactoryGirl.create(:customer)
        sign_in @customer
        expect(Order.count).to eql(0)
        post :create, params: { 
          restaurant_id: @restaurant.id, 
          order_item: {
            menu_item_id: @restaurant.menu_items.last.id,
            quantity: 3
          }
        }
        expect(response).to have_http_status(:found) #302
        expect(response).to redirect_to(@restaurant)
        expect(flash[:notice]).to eql("Order item was successfully created.")
        expect(Order.count).to eql(1)

        order = Order.last
        expect(order.restaurant).to eql(@restaurant)
        expect(order.total_price_in_cents).to eql(2 * 3000)
      end
    end
  end
end
