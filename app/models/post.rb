class Post
  include Mongoid::Document

  field :content, type: String

  validates :content, presence: true
end
