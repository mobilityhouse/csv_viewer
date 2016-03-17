class DocumentExtension < ApplicationRecord
  belongs_to :document
  
  def is_type?(type_name)
    type_name == self.class.type ? true : false
  end
  
  def type
    ''
  end
  
  def update_attributes(new_attributes)
    update(extension_settings: ((extension_settings || {}).merge(new_attributes)))
  end
  
end
