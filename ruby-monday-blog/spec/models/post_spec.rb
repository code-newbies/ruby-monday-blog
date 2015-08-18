require 'rails_helper'

describe Post do
  describe Post, 'validation' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:body)}
    it {should have_many(:tags)}
  end

  describe "associations" do
    it { is_expected.to belong_to :author }
  end

  describe "initial setup" do
    let(:post) {Post.create(title:"My Post", body:"My Content")}

    it "makes a new post with title" do
      expect(post.title).to eq("My Post")
    end

    it "makes a new post with body" do
      expect(post.body).to eq("My Content")
    end

    it "has a tag with the post" do
      @tag = post.tags.build(content:"Rails")
      expect(@tag.content).to eq("Rails")
    end
  end
end
