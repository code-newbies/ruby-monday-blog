class Post < ActiveRecord::Base
  has_many :post_tags, inverse_of: :post
  has_many :tags, through: :post_tags

  validates :body, presence: true
  validates :title, presence: true
  
  accepts_nested_attributes_for :tags

end
