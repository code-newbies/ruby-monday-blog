require 'rails_helper'

describe Post do
  describe Post, 'validation' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:body)}
  end

  describe "initial setup" do
    let(:post) {Post.create(title:"My Post", body:"My Content")}

    it "makes a new post with title" do
      expect(post.title).to eq("My Post")
    end

    it "makes a new post with body" do
      expect(post.body).to eq("My Content")
    end
  end
end
