require "rails_helper"

RSpec.describe Manager, type: :model do
  specify "sanity check for making sure #type is set correctly for User with type :user" do
    u = Manager.create email: "rspec@test.com", password: "password"
    expect(u).to be
    expect(u.class).to eql(Manager)
    expect(u.type).to eql('Manager')
  end

  it "should be able to handle chef-manager relationships" do
    m = FactoryGirl.create(:manager)
    expect(m).to be
    expect(m.chefs.count).to eql(0)

    m.chefs << (chef=FactoryGirl.create(:chef))
    expect(m.chefs.count).to eql(1)
    expect(chef.manager).to eql(m)
  end

  it "should be able to handle manager-restaurant relationships" do
    m = FactoryGirl.create(:manager)
    expect(m).to be
    expect(m.restaurant).to be
  end

  describe "Callbacks" do
    context "#after_create" do
      it "should create a blank restaurant for the manager" do
        m = FactoryGirl.create(:manager)
        expect(m.restaurant).to_not be_nil
        expect(m.restaurant.name).to be_nil
        expect(m.restaurant.address).to be_nil
      end
    end
  end
end
