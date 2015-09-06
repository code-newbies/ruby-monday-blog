# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  title              :string
#  body               :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  author_id          :integer
#  slug               :string
#
# Indexes
#
#  index_posts_on_author_id  (author_id)
#  index_posts_on_slug       (slug) UNIQUE
#

require 'rails_helper'

describe Post do
  describe Post, 'validation' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:body)}
    it {should have_many(:tags)}
  end

  describe "associations" do
    it {should belong_to :author}
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
