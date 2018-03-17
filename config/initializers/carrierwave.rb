if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AKIAJTUQRT5QR6CTRFMA'],
      :aws_secret_access_key  => ENV['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'],     # required
    }
    config.storage = :aws
    config.aws_directory  = ENV['recordalbumbucket']                 # required
    config.aws_public     = true                                   # optional, defaults to true
    config.root = Rails.root.join('tmp')
    config.cache_dir = '#{Rails.root}/tmp/uploads'
    config.permissions = 0777
    config.aws_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
else
  CarrierWave.configure do |config|
    config.storage :file
  end
end
