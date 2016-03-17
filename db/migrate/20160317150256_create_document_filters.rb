class CreateDocumentFilters < ActiveRecord::Migration[5.0]
  def change
    create_table :document_filters do |t|
      t.integer :document_id
      t.string :phrase_filter
      t.json :column_filter
      t.timestamps
    end
  end
end
