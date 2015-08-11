require 'rails_helper'

describe Tag do
  it { should have_many(:posts) }
  it { should validate_uniqueness_of(:content) }

  it "generates a new tag" do
    @tag = Tag.new(content:"Ruby")
    expect(@tag.content).to eq("Ruby")
  end
end
