module DocumentExtensions

  class S3 < DocumentExtension
    
    def aws_access_key_id
      extension_settings['aws_access_key_id']
    end

    def aws_secret_access_key
      extension_settings['aws_secret_access_key']
    end

    def aws_region
      extension_settings['aws_region']
    end

  end

end
