require 'rails_helper'

describe Team do
  context "when a team is being created" do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:full_name) }
    it { should have_many(:players)}
  end
end
