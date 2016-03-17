module DocumentDecorators
  
  class S3 < Draper::Decorator
  
    delegate :name, :columns
      
    def rows
      object.rows.tap do |r|
        r.each do |row|
          extension.columns.each do |col|
            row[col] = extension.signed_link(row[col])
          end
        end
      end
    end
    
    private
    
    def extension
      object.document_extension
    end
    
  end
  
end