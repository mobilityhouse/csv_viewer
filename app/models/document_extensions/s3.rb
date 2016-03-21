module DocumentExtensions

  class S3 < DocumentExtension
    
    def self.type
      'S3'
    end
    
    def self.decorator_class
      DocumentDecorators::S3
    end
    
    def signed_link(filename)
      "<a href='#{presigned_url(filename)}'>#{filename}</a>"
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
    
    def aws_path
      ap = extension_settings['aws_path']
      return '' if ap.blank?
      ap[0] == '/' ? ap[1..-1] : ap 
    end
    
    def columns
      extension_settings['columns'] || []
    end
    
    private
    
    def presigned_url(filename)
      s3_presigner.presigned_url(:get_object, bucket: aws_bucket, key: aws_key(filename))
    end
    
    def aws_key(filename)
      Pathname.new(aws_path).join(filename).to_s
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
