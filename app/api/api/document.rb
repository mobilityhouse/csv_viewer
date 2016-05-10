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
        document_extension = document.document_extension
        document_decorator_class = document_extension.class.try(:decorator_class)
        document = document_decorator_class.decorate(document) if document_decorator_class.present?
        {
          name: document.name,  
          columns: document.columns,
          rows: document.rows,
          extension_type: document_extension.class.try(:type),
          extension_settings: document_extension.try(:current_extension_settings)
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
      
      params do
        requires :type, values: DOCUMENT_TYPES
        requires :file_id, type: Integer
        requires :attributes, type: Array[String]
      end
      get '/attribute' do
        doc = document_class.find(params[:file_id])
        params[:attributes].reduce({}) do |acc, attribute_name|
          acc.tap do |a|
            a[attribute_name] = doc.get_attribute(attribute_name)
          end
        end
      end
    
    end
    
  end
end
