CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAI53DFWDU22POTZTQ',                        # required
    aws_secret_access_key: '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',                        # required
    region:                'eu-east-1',                  # optional, defaults to 'us-east-1'
    host:                  's3.example.com',             # optional, defaults to nil
    endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
  }

  config.fog_provider = 'fog'                        # required

  config.fog_directory  = 'album-records-production'                                   # required
  config.fog_public     = false                                                 # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end
