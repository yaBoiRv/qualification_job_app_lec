# frozen_string_literal: true

class AvatarUploader < CarrierWave::Uploader::Base
  # Include CarrierWave::MiniMagick for image resizing
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog # Use AWS S3 or other cloud storage if needed

  # Override the default URL to return a default image if no avatar is present
  def default_url(*_args)
    ActionController::Base.helpers.asset_path('user.png')
  end

  # Process files as they are uploaded:
  process resize_to_fit: [200, 200]

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fill: [50, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w[jpg jpeg png]
  end
end
