class User < ActiveRecord::Base
  has_many :posts

  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true

  validates_length_of :password, minimum: 7
  validates_uniqueness_of :email
  validates_presence_of :email, :password
end
