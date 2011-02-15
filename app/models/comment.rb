class Comment
  include Mongoid::Document
  embedded_in :image, :inverse_of => :comments

  field :body
  field :author
  field :rating, :type => Integer, :default => 0
end