# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :string
#

class Tag < ActiveRecord::Base
  # associations
  has_many :post_tags, inverse_of: :tag
  has_many :posts, through: :post_tags

  # validations
  validates_uniqueness_of(:content)
end
