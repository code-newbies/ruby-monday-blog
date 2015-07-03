require 'rails_helper'

describe Tag do
  it {should have_many(:posts)}

  it "generates a new tag" do
    @tag = Tag.new(content:"Ruby")
    expect(@tag.content).to eq("Ruby")
  end
end
