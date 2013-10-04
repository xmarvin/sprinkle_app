if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage           = :file
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
        :provider              => 'AWS',
        :aws_access_key_id     => 'AKIAIJ3UAXEIII5IO3CA',
        :aws_secret_access_key => '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'
    }
    config.fog_directory   = 'coachalba'
    config.fog_public      = true
  end
end