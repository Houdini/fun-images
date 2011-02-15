require 'carrierwave/orm/mongoid'
class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :is_checked, :type => Boolean, :default => false
  field :title, :type => String
  field :description, :type => String
  mount_uploader :image, ImageUploader
  field :shown_date, :type => Date
  embeds_many :comments

  attr_accessible :title, :description, :image, :shown_date

  validates_presence_of :image

  referenced_in :user
end