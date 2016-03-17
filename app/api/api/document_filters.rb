module Api
  class DocumentFilters < Grape::API
    
    DOCUMENT_TYPES = ['CsvDocument']    
    
    format :json
    formatter :json, Grape::Formatter::Jbuilder
    
    before do
      ApplicationHelper.authenticate!(env, params, return_401)
    end
    
    helpers do
      
      def return_401
        Proc.new{ error!("401 Unauthorized", 401) }
      end
      
      def return_404
        Proc.new{ error!("404 Not found", 404) }
      end
      
    end
    
    namespace :document_filter do
    
      params do
        requires :type, values: DOCUMENT_TYPES
        requires :file_id, type: Integer
      end
      get '/' do
        ApplicationHelper.document(params[:type], params[:file_id], return_404).document_filter.try(:to_hash) || DocumentFilter.null_filter
      end
      
      params do
        requires :type, values: DOCUMENT_TYPES
        requires :file_id, type: Integer
        requires :filter_settings, type: JSON do
          requires :phrase_filter, type: String
          requires :column_filter, type: Array[String]
        end
      end
      post '/' do
        ApplicationHelper.authenticate_as_admin!(env, params, return_401)
        ApplicationHelper.document(params[:type], params[:file_id], return_404).update_filter(params[:filter_settings])
        params[:filter_settings]
      end
      
    
    end
    
  end
end