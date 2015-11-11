class User < ActiveRecord::Base
  has_many :posts

  has_secure_password
  has_attached_file :avatar, styles: { thumb: "150x150>" }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true
  validates_uniqueness_of :email
  validates_presence_of :email
end
