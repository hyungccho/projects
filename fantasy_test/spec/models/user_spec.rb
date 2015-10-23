require 'rails_helper'

describe User do
  context "when a user is being created" do
    subject (:valid_user) { FactoryGirl.build(:valid_user) }
    subject! (:duplicate_user) { FactoryGirl.create(:duplicate_user) }

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:session_token) }
    it { should have_many(:user_memberships) }
    it { should have_many(:participating_leagues) }
    it { should have_many(:players) }

    it "should not add duplicate usernames" do
      second_dup = FactoryGirl.build(:duplicate_user)

      expect(second_dup).to_not be_valid
    end
  end
end
