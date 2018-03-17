if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AKIAJTUQRT5QR6CTRFMA'],
      :aws_secret_access_key  => ENV['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'],     # required
    }
    config.fog_directory  = ENV['recordalbumbucket']                 # required
    config.fog_public     = true                                   # optional, defaults to true
    config.root = Rails.root.join('tmp')
    config.cache_dir = 'files'
    config.permissions = 0777
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
else
  CarrierWave.configure do |config|
    config.storage :file
  end
end
