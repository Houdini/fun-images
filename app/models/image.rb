require 'carrierwave/orm/mongoid'
class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  field :is_checked, :type => Boolean, :default => false
  field :title, :type => String
  field :description, :type => String
  mount_uploader :image, ImageUploader
  field :shown_date, :type => Integer
  field :alt

  attr_accessible :title, :description, :image, :shown_date

  validates_presence_of :image

  referenced_in :user
  references_many :comments

  class << self
    def find_closest_images image
      return [] unless image
      days_limit = 5
      if image.shown_date < Date.today

      else
        Image.desc(:shown_date).limit days_limit
      end
    end
  end

end