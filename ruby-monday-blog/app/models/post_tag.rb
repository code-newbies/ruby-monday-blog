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

class PostTag < ActiveRecord::Base
  # associations
  belongs_to :post
  belongs_to :tag

  # validations
  validates :tag, uniqueness: { scope: :post }
end
