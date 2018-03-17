if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AKIAJHOGTRGBTEGN2AUA'],
      :aws_secret_access_key => ENV['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'],
      :region                => ENV['us-east-2']
    }
    config.fog_directory  =  ENV['recordalbumbucket']
  end
end
