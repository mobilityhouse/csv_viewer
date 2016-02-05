module Api
  class Document < Grape::API
    
    DOCUMENT_TYPES = ['CsvDocument']    
    
    format :json
    formatter :json, Grape::Formatter::Jbuilder
    
    helpers do
      
      def document_class
        params[:type].constantize
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
      end
      post '/' do
        document_class.new(
          name: params[:name], 
          file: params[:file][:tempfile].read,
          additional_params: params[:additional_params]
        ).save!
      end
    
    end
    
  end
end