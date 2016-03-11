module Api
  class DocumentSettings < Grape::API
    
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
        ApplicationHelper.authenticate_as_admin!(env, params, return_401)
        doc = document_class.find(params[:file_id])
        doc.additional_params = params[:new_settings]
        doc.save!
      end
      
    
    end
    
  end
end