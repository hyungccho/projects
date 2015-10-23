require 'rails_helper'

describe Player do
  context "when a player is being created" do
    it { should validate_presence_of(:active) }
    it { should validate_presence_of(:jersey) }
    it { should validate_presence_of(:lname) }
    it { should validate_presence_of(:fname) }
    it { should validate_presence_of(:team) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:dob) }
    it { should have_many(:rankings) }
    it { should have_many(:league_memberships) }
    it { should have_many(:leagues) }
    it { should belong_to(:organization) }
  end
end
