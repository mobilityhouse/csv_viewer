module DocumentExtensions

  class S3 < DocumentExtension
    
    def self.type
      'S3'
    end
    
    def self.decorator_class
      DocumentDecorators::S3
    end
    
    def signed_link(uri)
      parsed_uri = URI(uri)
      "<a href='#{presigned_url(parsed_uri)}'>#{file_name(parsed_uri)}</a>"
    end
    
    def aws_access_key_id
      extension_settings['aws_access_key_id']
    end

    def aws_secret_access_key
      extension_settings['aws_secret_access_key']
    end

    def aws_region
      extension_settings['aws_region']
    end
    
    def aws_bucket
      extension_settings['aws_bucket']
    end
    
    def columns
      extension_settings['columns'] || []
    end
    
    private
    
    def presigned_url(uri)
      s3_presigner.presigned_url(:get_object, bucket: aws_bucket, key: uri.path[1..-1])
    end
    
    def file_name(uri)
      uri.path.split('/').last
    end
    
    def s3_presigner
      Aws::S3::Presigner.new({client: s3_client})
    end
    
    def s3_client
      Aws::S3::Client.new(region: aws_region, credentials: credentials)
    end
    
    def credentials
      Aws::Credentials.new(aws_access_key_id, aws_secret_access_key)
    end
    
  end

end
