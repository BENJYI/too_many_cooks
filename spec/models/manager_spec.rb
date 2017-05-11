require "rails_helper"

RSpec.describe Manager, type: :model do
  specify "sanity check for making sure #type is set correctly for User with type :user" do
    u = Manager.create email: "rspec@test.com", password: "password"
    expect(u).to be
    expect(u.class).to eql(Manager)
    expect(u.type).to eql('Manager')
  end
end
