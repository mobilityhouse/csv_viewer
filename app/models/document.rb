class Document < ApplicationRecord
  has_one :document_extension, dependent: :destroy
  has_one :document_filter, dependent: :destroy
  validates :name, :file, :type, presence: true
  
  def extension_type
    additional_params['extension']
  end
  
  def has_extension?
    extension_type.present?
  end
  
  def extension_class
    return nil unless has_extension?
    "DocumentExtensions::#{extension_type}".constantize
  end
  
  def update_filter(params)
    DocumentFilter.find_or_initialize_by(document_id: id).tap do |df|
      df.phrase_filter = params[:phrase_filter]
      df.column_filter = params[:column_filter]          
    end.save!
  end
  
  def update_params_and_extension(additional_params, extension_params)
    self.additional_params = additional_params
    save!
    if has_extension?
      extension = extension_class.find_or_initialize_by(document_id: id)
      extension.extension_settings = extension_params
      extension.save!
    else
      DocumentExtension.delete_all(document_id: id)
    end
    
  end
  
end
