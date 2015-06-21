require 'rails_helper'

describe Post do
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
