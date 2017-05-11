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
end
