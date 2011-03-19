class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :omniauthable


  with_options :if => :direct_registration? do |v|
    v.validates_presence_of   :email
    v.validates_format_of     :email, :with  => /\A([\p{Word}\.%\+\-]+)@([\p{Word}\-]+\.)+([\p{Word}]{2,})\z/i, :allow_blank => true

    v.validates_presence_of     :password
    v.validates_confirmation_of :password
#    v.validates_length_of       :password, :within => 4, :allow_blank => true
  end

  field :role, :type => Integer, :default => 10
  field :nick
  field :avatar
  field :oauth, :type => Array, :default => []
  field :like_comments, :type => Array, :default => []
  field :rating, :type => Integer, :default => 0

  references_many :images
  references_many :comments
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

  def find_in_like_comments comment_id
    like_comments.select {|like_comment_id| like_comment_id == comment_id.to_s}
  end

  class << self
    def find_or_create_for_facebook_oauth facebook_data
      if user = User.where(:oauth.in => ["facebook #{facebook_data['uid']}"]).first
        user
      else
        nick = if facebook_data.has_key?("user_info") and facebook_data['user_info'].has_key? 'nickname'
          facebook_data['user_info']['nickname']
        else
          facebook_data['extra']['user_hash']['first_name']
        end
        user = User.create :nick => nick, :oauth => ["facebook #{facebook_data['uid']}"]
      end
      user
    end

    def find_or_create_for_vkontakte_oauth vk_data
      if user = User.where(:oauth.in => ["vk #{vk_data['uid']}"]).first
        user
      else
        nick = if vk_data.has_key?("user_info") and vk_data['user_info'].has_key? 'nickname'
          vk_data['user_info']['nickname']
        else
          vk_data['extra']['user_hash']['first_name']
        end

        user = User.create :nick => nick, :oauth => ["vk #{vk_data['uid']}"], :avatar => vk_data['user_info']['image']
      end
      user
    end
  end

  protected
  def direct_registration?
    new_record? and oauth.size == 0
  end
end
