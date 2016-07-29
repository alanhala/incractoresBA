CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV["AWS_ACCESS_KEY_ID"],
      :aws_secret_access_key  => ENV["AWS_SECRET_ACCESS_KEY"],
      :region                 => "us-east-1"
    }
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.fog_directory  = "infracciones-ba-#{Rails.env}"
  end
end
