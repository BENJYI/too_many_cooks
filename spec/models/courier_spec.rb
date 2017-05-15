require 'rails_helper'

RSpec.describe Courier, type: :model do
  specify "sanity check for making sure #type is set correctly for User with type :user" do
    u = Courier.create email: "rspec@test.com", address: "123 Random Street", password: "password"
    expect(u).to be
    expect(u.class).to eql(Courier)
    expect(u.type).to eql('Courier')
  end

  it "should be able to handle courier-restaurant/menu_items relationships" do
    m = FactoryGirl.create(:manager)
    c = FactoryGirl.create(:courier, manager: m)
    r = FactoryGirl.create(:restaurant, manager: m)

    expect(r.manager).to eql(m)
    expect(c.manager.restaurant).to eql(r)
    expect(r.couriers).to match_array([c])

  end

end
