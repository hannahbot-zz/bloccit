# Adding Amazon S3 to Carrierwave
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
    :region                 => ENV['AWS_REGION']
  }
  config.fog_directory  = ENV['AWS_BUCKET']
  config.fog_public     = false

class AvatarUploader < CarrierWave::Uploader::Base
  storage :fog
end

if Rails.env.test? || Rails.env.development?
  config.storage = :file
  config.enable_processing = false
  config.root = "#{Rails.root}/tmp"
else
  config.storage = :fog
end

config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku

end

# Ref:
# https://support.cloud.engineyard.com/entries/20996881-Use-CarrierWave-and-Optionally-Fog-to-Upload-and-Store-Files#update3
# http://stackoverflow.com/questions/7946819/carrierwave-and-amazon-s3