# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  def store_dir
#    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    ";-)/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
#  process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [65, 65]
    process :convert => 'png'
  end

  process :resize_to_fit => [540, 400]
  process :convert => 'png'


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg png)
  end

#  Override the filename of the uploaded files:
  def filename
     "i.png" if original_filename
  end

def cache_dir
  "#{Rails.root}/tmp/uploads"
end

#  def crop_image
#    manipulate! do |img|
#      img.crop!(10, 10, 65, 65)
#      img.crop!(model.crop_x.to_i, model.crop_y.to_i, model.crop_w.to_i, model.crop_h.to_i)
#      img
#    end
    
#  end

end