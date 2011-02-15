class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :email, :password, :password_confirmation  

  field :role, :type => Integer, :default => 10

  references_many :images
end
