class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :email, :password, :password_confirmation

  field :role, :type => Integer, :default => 10
  field :nick

  references_many :images
  embeds_many :user_like_comments

  def before_save
    unless nick
      self.nick = email.split('@').first
    end
  end

  def nick
    if super
      super
    else
      email.split('@').first
    end
  end

  def find_in_like_comments comment_id, image_id
    user_like_comments.select {|like_comment| like_comment.comment_id == comment_id.to_s and like_comment.image_id == image_id.to_s}
  end
end