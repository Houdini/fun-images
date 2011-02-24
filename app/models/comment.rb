class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :image, :inverse_of => :comments

  field :body
  field :author
  field :rating, :type => Integer, :default => 0
  field :like_users, :type => Array, :default => []

  validates_length_of :body, :minimum => 3, :maximum => 250

  def user_author
    User.find author
  end
end