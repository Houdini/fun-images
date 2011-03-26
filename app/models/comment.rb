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
  before_create :add_commented_image_to_author

  def add_commented_image_to_author
    new_shown_date = image.shown_date
    unless user.commented_images.include? new_shown_date
      user.commented_images << new_shown_date
      user.save
    end
  end

  def editable?
    like_users.size == 0 and created_at  + 2.hours > Time.now
  end

  class << self
    def max_characters; @@max_characters end
  end

  protected

    def remove_all_mentions
      like_users.each do |user_id|
        user = User.where(_id: user_id).first
        user.like_comments.reject!{|comment| comment.to_s == _id.to_s}

        comments_at_this_day = Comment.where(user_id: user_id, image_id: image_id).all
        if comments_at_this_day.count == 1
          user.commented_images.reject!{|show_date| show_date == comment.image._id}
        end

        user.save
      end
    end

    def if_comments_hit_max_limit
      errors.add(:body, I18n.t(:too_much_comments)) if image.comments.select{|comment| comment.user == user}.count > 3
    end

end
