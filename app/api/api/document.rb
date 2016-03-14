module Api
  class Document < Grape::API
    
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
    
    namespace :document do
    
      params do
        requires :type, values: DOCUMENT_TYPES
        requires :id, type: Integer
      end
      get '/' do
        document = document_class.find(params[:id])
        {
          name: document.name,  
          columns: document.columns,
          rows: document.rows
        }
      end
      
      params do
        requires :type, values: DOCUMENT_TYPES
      end
      get '/list', jbuilder: 'document/list.jbuilder' do
        @documents = document_class.order(:name)
      end
      
      params do
        requires :type, values: DOCUMENT_TYPES
        requires :name
        requires :file
        requires :additional_params, type: String
        optional :extension_params, type: String
      end
      post '/' do
        ApplicationHelper.authenticate_as_admin!(env, params, return_401)
        doc = document_class.new(
          name: params[:name], 
          file: params[:file][:tempfile].read,
          additional_params: params[:additional_params]
        )
        doc.save!
        if doc.has_extension?
          doc.extension_class.new({document: doc, extension_settings: params[:extension_params]}).save!
        end
        { created_file_name: doc.name, created_file_id: doc.id }
      end
      
      params do
        requires :type, values: DOCUMENT_TYPES
        requires :file_id
      end
      delete '/' do
        ApplicationHelper.authenticate_as_admin!(env, params, return_401)
        document_class.find(params[:file_id]).destroy
      end
    
    end
    
  end
end