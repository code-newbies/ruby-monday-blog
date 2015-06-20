require 'rails_helper'

RSpec.describe Post, type: :model do
  it "makes a new post with title" do
    post = Post.new(title: "My Post", body:"My Post Content")
    expect(post.title).to eq("My Post")
    expect(post.body).to eq("My Post Content")
  end
end
