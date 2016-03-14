class CreateDocumentExtensions < ActiveRecord::Migration[5.0]
  
  def change
    create_table :document_extensions do |t|
      t.string :name
      t.string :type
      t.integer :document_id
      t.json :extension_settings
      t.timestamps
    end
  end
  
end
