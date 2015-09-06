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

class Post < ActiveRecord::Base
  # associations
  has_many :post_tags, inverse_of: :post
  has_many :tags, through: :post_tags
  has_attached_file :image, styles: { thumb: '100x100>' }
  belongs_to :author, class_name: 'User'
  accepts_nested_attributes_for :tags

  before_validation :autosave_associated_records_for_tags

  # validations
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :body, presence: true
  validates :title, presence: true

  # scopes
  scope :ordered_by_created_at, -> { order(created_at: :desc) }

  # gems
  extend FriendlyId
  friendly_id :title, use: :slugged
  paginates_per 10

  # delegations
  delegate :full_name, to: :author, prefix: true

private

  def autosave_associated_records_for_tags
    self.tags = tags.map { |tag| prepare_tag(tag) }
  end

  def prepare_tag(tag)
    Tag.find_or_create_by(content: tag.content.titleize)
  end
end
