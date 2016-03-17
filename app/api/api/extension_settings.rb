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
      
      def return_404
        Proc.new{ error!("404 Not found", 404) }
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
      
      params do
        requires :type, values: DOCUMENT_TYPES
        requires :file_id, type: Integer
        requires :extension_type, type: String
        requires :extension_attributes, type: JSON
      end
      
      patch '/' do
        ApplicationHelper.authenticate_as_admin!(env, params, return_401)
        extension = document_class.find(params[:file_id]).document_extension
        return_404.call if extension.blank? || extension.try(:is_type?, params[:extension_type]).blank?
        extension.update_attributes(params[:extension_attributes])
        {ok: true}
      end
    
    end
    
  end
end