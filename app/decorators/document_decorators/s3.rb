module DocumentDecorators
  
  class S3 < Draper::Decorator
  
    delegate :name
    
    def columns
      object.columns - extension.columns + [extension.class::DOC_COLUMN]
    end
      
    def rows
      object.rows.tap do |r|
        r.each_with_index do |row, index|
          row[extension.class::DOC_COLUMN] = extension.links_collection(row, index)
          extension.columns.each do |col|
            row.delete col
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