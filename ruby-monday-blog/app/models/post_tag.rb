class PostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :tag

  validates :tag, uniqueness: { scope: :post }
end
