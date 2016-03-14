module Api
  class ExtensionSettings < Grape::API
    
    DOCUMENT_TYPES = ['CsvDocument']    
    
    format :json
    formatter :json, Grape::Formatter::Jbuilder
    
    before do
      ApplicationHelper.authenticate!(env, params, return_401)
    end
    
    helpers do
      
      def document_class
        params[:type].constantize
      end
      
      def return_401
        Proc.new{ error!("401 Unauthorized", 401) }
      end
      
    end
    
    namespace :extension_settings do
    
      params do
        requires :type, values: DOCUMENT_TYPES
        requires :file_id, type: Integer
      end
      get '/' do
        document_class.find(params[:file_id]).document_extension.try(:extension_settings) || {}
      end
    
    end
    
  end
end