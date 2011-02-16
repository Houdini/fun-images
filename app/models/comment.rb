class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :image, :inverse_of => :comments

  field :body
  field :author
  field :rating, :type => Integer, :default => 0

  def user_author
    User.find author
  end
end