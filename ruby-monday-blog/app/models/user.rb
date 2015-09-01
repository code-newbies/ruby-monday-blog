# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :integer
#  first_name             :string
#  last_name              :string
#

class User < ActiveRecord::Base
  # lifecycle callbacks
  before_create :set_default_role, if: :new_record?

  # associations
  has_many :posts, foreign_key: :author_id
  validates :first_name, :last_name, presence: true, if: :author?

  # Use enum for roles ref: http://railsapps.github.io/rails-authorization.html
  # This allows roles to be stored in the db as an int index, but allows us to
  # use sensible, familiar strings for names.
  enum role: [:reader, :author, :admin]

  # gems
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # instance methods
  def full_name
    return 'Anonymous' if first_name.blank? && last_name.blank?
    [first_name, last_name].join(' ')
  end

private

  def set_default_role
    self.role ||= :reader
  end
end
