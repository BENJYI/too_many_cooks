require 'rails_helper'

RSpec.describe Chef, type: :model do

  def test_upvote_downvote(upvote:, downvote:, assert_status:, assert_updown:)

  end

  specify "sanity check for making sure #type is set correctly for User with type :user" do
    u = Chef.create email: "rspec@test.com", address: "123 Random Street", password: "password"
    expect(u).to be
    expect(u.class).to eql(Chef)
    expect(u.type).to eql('Chef')
  end

  it "should be able to handle chef-restaurant/menu_items relationships" do
    m = FactoryGirl.create(:manager)
    c = FactoryGirl.create(:chef, manager: m)
    r = FactoryGirl.create(:restaurant, manager: m)

    expect(r.manager).to eql(m)
    expect(c.manager.restaurant).to eql(r)
    expect(r.chefs).to match_array([c])
  end

  describe "Promoting/Demoting" do
    before do
      @manager = FactoryGirl.create(:manager)
      @chef = FactoryGirl.create(:chef, manager: @manager)
      @restaurant = FactoryGirl.create(:restaurant, manager: @manager)
    end

    it "sets the chef's default status to :neutral and updown to 0" do
      expect(@chef.status).to eql("neutral")
      expect(@chef.updown).to eql(0)
    end

    describe "#reset_promotion_step!" do
      it "should reset status to :neutral, and reset updown to 0" do
        @chef.update status: :good, updown: 2  # start with someting not netural and not 0
        expect(@chef.status).to eql("good")
        expect(@chef.updown).to eql(2)

        @chef.reset_promotion_step!
        expect(@chef.status).to eql("neutral")
        expect(@chef.updown).to eql(0)
      end
    end

    context "upvoting a :neutral chef" do
      it "should promote the chef to the correct statuses and reset the updown count to 0 on each status upgrade" do
        3.times { @chef.upvote }
        expect(@chef.updown).to eql(0)
        expect(@chef.status).to eql("good")

        3.times { @chef.upvote }
        expect(@chef.updown).to eql(0)
        expect(@chef.status).to eql("great")

        3.times { @chef.upvote }
        expect(@chef.updown).to eql(0)
        expect(@chef.status).to eql("excellent")

        # Should prevent promotions (any # of upvotes should be meaningless)
        5.times { @chef.upvote }
        expect(@chef.updown).to eql(0)
        expect(@chef.status).to eql("excellent")
      end
    end

    context "downvoting a :neutral chef 3 times" do
      it "should promote the chef to :danger and reset the updown count to 0" do
        3.times { @chef.downvote }
        expect(@chef.updown).to eql(0)
        expect(@chef.status).to eql("danger")

        3.times { @chef.downvote }
        expect(@chef.updown).to eql(0)
        expect(@chef.status).to eql("fired")

        # Should prevent demotions (any # of downvotes should be meaningless)
        5.times { @chef.downvote }
        expect(@chef.updown).to eql(0)
        expect(@chef.status).to eql("fired")
      end
    end

    context "mixed upvoting/downvoting" do
      it "should return the correct results" do
        @chef.reset_promotion_step!
        2.times { @chef.downvote }
        1.times { @chef.upvote }
        expect(@chef.status).to eql("neutral")

        @chef.reset_promotion_step!
        4.times { @chef.upvote }
        1.times { @chef.downvote }
        expect(@chef.status).to eql("good")

        @chef.reset_promotion_step!
        4.times { @chef.upvote }
        1.times { @chef.downvote }
        expect(@chef.status).to eql("good")

        @chef.reset_promotion_step!
        6.times { @chef.upvote }
        8.times { @chef.downvote }
        expect(@chef.status).to eql("neutral")
      end
    end
  end

end
