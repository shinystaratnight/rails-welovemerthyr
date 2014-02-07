class Download
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :file, type: String

  attr_accessible :title, :file, :remove_file

  mount_uploader :file, DownloadUploader

  scope :newest, desc(:created_at)
end
