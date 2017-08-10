CarrierWave.configure do |config|

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :aws
    config.aws_bucket = ENV.fetch("S3_BUCKET_NAME")
    config.aws_acl = "public-read"
    config.aws_credentials = {
      access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
      secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
      region: "us-east-1" }
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads" # for Heroku
end
