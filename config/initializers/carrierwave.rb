CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => "AWS",
    :aws_access_key_id => "AKIAI4G5BPFTKAM4FG2Q",
    :aws_secret_access_key => "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",
    :region => "eu-west-1"
  }

  config.fog_directory = "welovemerthyr"
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  config.fog_public = true

  if Rails.env.production?
    config.storage = :fog
  elsif Rails.env.development?
    config.storage = :file
#    config.storage = :fog
  elsif Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end
end
