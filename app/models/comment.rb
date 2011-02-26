class Comment
  @@max_characters = 250
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :image, :inverse_of => :comments

  field :body
  field :author
  field :rating, :type => Integer, :default => 0
  field :like_users, :type => Array, :default => []

  validates_length_of :body, :minimum => 3, :maximum => @@max_characters
  validates_uniqueness_of :body

  def user_author
    User.find author
  end

  class << self
    def max_characters; @@max_characters end
  end
end
