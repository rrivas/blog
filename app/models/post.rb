class Post
  include Mongoid::Document

  field :title, type: String
  field :description, type: String
  field :content, type: String

  attr_accessible :title, :description, :content

  validates :title, presence: true
  validates :description, presence: true
  validates :content, presence: true
end
