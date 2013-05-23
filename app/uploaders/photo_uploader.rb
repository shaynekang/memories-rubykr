# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  version :grid do
    process :resize_to_fill => [150, 117]
  end

  version :detail do
    process :resize_to_limit => [768, nil]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
