class Post < ActiveRecord::Base
  has_many :comments
  has_many :post_tags
  has_many :tags, through: :post_tags
  belongs_to :user

  def tag_names
    self.tags.map(&:name).join(", ")
  end

  def tag_names=(new_tags)
    tag_models = new_tags.split(", ").map { |name| Tag.find_or_create_by(name: name) }
    self.tags = tag_models
  end
end
