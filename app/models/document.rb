require Rails.root.join('lib', 'file_size_validator')

class Document < ActiveRecord::Base
  belongs_to :user
  
  mount_uploader :file, DocumentUploader
  
  validates :file, :presence => true,
    :file_size => {
      :maximum => 10.megabytes.to_i
    }

  process_in_background :file
end
