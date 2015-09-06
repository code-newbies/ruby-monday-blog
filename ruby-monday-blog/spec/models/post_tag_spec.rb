# == Schema Information
#
# Table name: post_tags
#
#  post_id :integer          not null
#  tag_id  :integer          not null
#
# Indexes
#
#  index_post_tags_on_post_id_and_tag_id  (post_id,tag_id) UNIQUE
#

require 'rails_helper'

describe PostTag do
  it { should belong_to(:tag) }
  it { should belong_to(:post) }

  let!(:post) { Post.create(body: 'A post body', title: 'A post title') }
  let!(:tag)  { Tag.create(content: 'Tag content') }

  it 'should allow tagging of posts' do
    post.tags << tag
    expect(post.tags).to match_array [tag]
  end

  it 'should prevent duplicate tags on posts (application layer)' do
    post.tags << tag
    expect { post.tags << tag }.to raise_error ActiveRecord::RecordInvalid
  end

  it 'should prevent duplicate tags on posts (database layer)' do
    post.tags << tag
    post_tag = PostTag.new(post: post, tag: tag)
    expect { post_tag.save(validate: false) }.to raise_error ActiveRecord::RecordNotUnique
  end
end
