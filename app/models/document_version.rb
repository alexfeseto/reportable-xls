class DocumentVersion < ActiveRecord::Base
  mount_uploader :file, DocumentUploader

  validates :name, :presence => true
  validates :file, :presence => true,
    :file_size => {
      :maximum => 10.megabytes.to_i
    }
  
  belongs_to :document
  # process_in_background :file
  
  after_save(on: :update) do |record|
    record.document.latest_version_id = record.id
    record.document.save
  end
end
