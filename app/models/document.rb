require Rails.root.join('lib', 'file_size_validator')

class Document < ActiveRecord::Base
  paginates_per 20

  belongs_to :user

  mount_uploader :file, DocumentUploader

  validates :name, :presence => true
  validates :file, :presence => true,
    :file_size => {
      :maximum => 10.megabytes.to_i
    }

  # process_in_background :file

  scope :top_by_user, lambda {|user_id|
    select("id, name").where({user_id: user_id}).order("updated_at DESC")
  }

end
