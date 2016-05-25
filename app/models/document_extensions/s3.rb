module DocumentExtensions

  class S3 < DocumentExtension
    
    DOC_COLUMN = 'S3_Documents'
    
    def self.type
      'S3'
    end
    
    def self.decorator_class
      DocumentDecorators::S3
    end
    
    def change_columns?
      true
    end
    
    def document_columns(doc)
      doc.columns - columns + [DOC_COLUMN]
    end
    
    def links_collection(row, index)
      select_tag(index) do |s|
        columns.map do |c|
          signed_link(row[c])
        end.join
      end
    end
    
    def select_tag(id, &block)
      select_id = "s3_doc_select_#{id}"
      "<form class=\"form-inline\">
       <select id=#{select_id} selected=''><option value=''></option>#{ yield('') }</select>
       <button class=\"btn btn-default\" onClick=\"#{click_func(select_id)}\">Open</button>
      </form>"
    end
    
    def click_func(select_id)
      "window.open($( '##{select_id}\' ).val(), '_blank')"
    end
    
    def signed_link(filename)
      return "" if filename.blank?
      begin
        "<option value='#{presigned_url(filename)}'>#{filename.gsub('/', '&sol;')}</option>"
      rescue Exception => e
        ""
      end
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
    
    def current_extension_settings
      extension_settings.tap do |es|
        es[:columns] = [DOC_COLUMN]
      end
    end
    
    private
    
    def presigned_url(filename)
      s3_presigner.presigned_url(:get_object, bucket: aws_bucket, key: aws_key(filename))
    end
    
    def aws_key(filename)
      Pathname.new(aws_path).join(filename).to_s
    end
    
    def s3_presigner
      @s3_presigner ||= Aws::S3::Presigner.new({client: s3_client})
    end
    
    def s3_client
      @s3_client ||= Aws::S3::Client.new(region: aws_region, credentials: credentials)
    end
    
    def credentials
      @credentials ||= Aws::Credentials.new(aws_access_key_id, aws_secret_access_key)
    end
    
  end

end
