# == Schema Information
#
# Table name: post_tags
#
#  post_id :integer          not null
#  tag_id  :integer          not null
#

class PostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :tag

  validates :tag, uniqueness: { scope: :post }
end
