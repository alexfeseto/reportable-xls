require Rails.root.join('lib', 'file_size_validator')

class Document < ActiveRecord::Base
  paginates_per 20

  belongs_to :user
  has_many :versions, dependent: :destroy, class_name: "DocumentVersion"
  belongs_to :latest_version, foreign_key: 'latest_version_id', class_name: "DocumentVersion"

  scope :top_by_user, lambda {|user_id|
    select("documents.id, document_versions.name name, document_versions.id version_id")
    .joins(:latest_version)
    .where({user_id: user_id})
    .order("documents.updated_at DESC")
  }
end
