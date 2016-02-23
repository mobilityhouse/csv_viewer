module Api
  class DocumentSettings < Grape::API
    
    DOCUMENT_TYPES = ['CsvDocument']    
    
    format :json
    formatter :json, Grape::Formatter::Jbuilder
    
    helpers do
      
      def document_class
        params[:type].constantize
      end
      
    end
    
    namespace :document_settings do
    
      params do
        requires :type, values: DOCUMENT_TYPES
        requires :file_id, type: Integer
      end
      get '/' do
        document_class.find(params[:file_id]).additional_params
      end
      
      params do
        requires :type, values: DOCUMENT_TYPES
        requires :file_id, type: Integer
        requires :new_settings
      end
      post '/' do
        doc = document_class.find(params[:file_id])
        doc.additional_params = params[:new_settings]
        doc.save!
      end
      
    
    end
    
  end
end