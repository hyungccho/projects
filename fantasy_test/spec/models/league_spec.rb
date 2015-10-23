require 'rails_helper'

describe League do
  context "when creating a league" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should have_many(:player_memberships) }
    it { should have_many(:players) }
    it { should have_many(:user_memberships) }
    it { should have_many(:users) }
    it { should have_one(:draft) }

    it "should default as an inactive league" do
      league = FactoryGirl.build(:league)

      expect(league.started).to be false
    end

    it "should default to a league that's not able to draft" do
      league = FactoryGirl.build(:league)

      expect(league.status).to be false
    end
  end

  describe "#activate" do
    before(:each) { @league = FactoryGirl.create(:league) }

    it "doesn't allow activation when there's not enough players" do
      @league.activate

      expect(@league.status).to be false
    end

    it "allows activation when 8 players satisfied" do
      8.times do |i|
        FactoryGirl.create(:valid_user, id: i + 1)
        FactoryGirl.create(:user_membership, user_id: i + 1, league_id: @league.id)
      end

      @league.activate

      expect(@league.status).to be true
    end
  end
end
