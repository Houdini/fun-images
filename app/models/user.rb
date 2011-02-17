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
end