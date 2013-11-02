class CreateDocumentVersions < ActiveRecord::Migration
  def change
    create_table :document_versions do |t|
      t.string :name
      t.text :xml_content
      t.string :file
      t.boolean :file_processing, :default => false

      t.references :document
      t.datetime :created_at
    end

    add_index :document_versions, :name
    add_index :document_versions, :file_processing

    remove_column :documents, :name
    remove_column :documents, :xml_content
    remove_column :documents, :file
    remove_column :documents, :file_processing
    
    add_column :documents, :latest_version_id, :integer
  end
end