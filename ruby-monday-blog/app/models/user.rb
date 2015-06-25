class User < ActiveRecord::Base

  # Define enum for roles  ref: http://railsapps.github.io/rails-authorization.html
  # This allows roles to be stored in the db as an int index, but allows us to use sensible, familiar strings for names.
  enum role: [:reader, :writer, :admin]

  # If we're creating a new user record, set the default role unless otherwise noted.
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    # assign self.role to :reader unless it already exists
    self.role ||= :reader
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
