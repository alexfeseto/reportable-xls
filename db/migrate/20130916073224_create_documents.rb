class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.text :xml_content
      t.string :file
      t.boolean :file_processing, :default => false
      t.timestamps
      
      t.references :user
    end
  end
end
