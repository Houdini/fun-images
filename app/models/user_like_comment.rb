class UserLikeComment
  include Mongoid::Document
  embedded_in :user, :inverse_of => :user_like_comments

  field :comment_id
  field :image_id
  field :body
end
