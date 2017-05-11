require "rails_helper"

RSpec.describe User, type: :model do
  specify "sanity check for making sure #type is set correctly for User with type :user" do
    u = User.create email: "rspec@test.com", password: "password"
    expect(u).to be
    expect(u.class).to eql(User)
    expect(u.type).to eql(nil)
  end
end
