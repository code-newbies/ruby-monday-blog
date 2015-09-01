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
#

class Post < ActiveRecord::Base
  # associations
  has_many :post_tags, inverse_of: :post
  has_many :tags, through: :post_tags
  has_attached_file :image, styles: {:thumb => "100x100>"}
  belongs_to :author, class_name: 'User'
  accepts_nested_attributes_for :tags

  # validations
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :body, presence: true
  validates :title, presence: true

  # scopes
  scope :ordered_by_created_at, -> { order(created_at: :desc) }

  # gems
  paginates_per 10

  # delegations
  delegate :full_name, to: :author, prefix: true

private

  def autosave_associated_records_for_tags
    tags.each { |tag| tags << prepare_tag(tag) }
  end

  def prepare_tag(tag)
    Tag.find_or_create_by(content: tag.content.titleize)
  end
end
