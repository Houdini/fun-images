class Comment
  @@max_characters = 250
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in :image
  referenced_in :user

  field :body
  field :rating, :type => Integer, :default => 0
  field :like_users, :type => Array, :default => []

  validates_length_of :body, :minimum => 3, :maximum => @@max_characters
  validates_uniqueness_of :body
  validate :if_comments_hit_max_limit

  def user_author
    user
  end

  def find_like_users
    like_users.map{|id| User.find id}
  end

  before_destroy :remove_all_mentions


  class << self
    def max_characters; @@max_characters end
  end

  protected
  def remove_all_mentions
    user_author.find_in_my_comments(id, image.id).each{|comment| comment.destroy}
    like_users.each do |user_id|
      user = User.find user_id
      user.find_in_like_comments(id, image.id).each{|comment| comment.destroy}
    end
  #if like users or any other method return nil, instead []
  rescue NoMethodError
  end

  def if_comments_hit_max_limit
    errors.add(:body, I18n.t(:too_much_comments)) if image.comments.select{|comment| comment.user == user}.count > 3
  end
end
