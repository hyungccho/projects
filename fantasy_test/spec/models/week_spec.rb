require 'rails_helper'

describe Week do
  context "when a week is being created" do
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:week_num) }
    it { should have_many(:rankings) }
  end
end
