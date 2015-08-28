class Download
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :file, type: String
  field :type, type: String, default: 0

  validates_presence_of :title, :file

  attr_accessible :title, :file, :remove_file

  mount_uploader :file, DownloadUploader

  scope :newest, desc(:created_at)
end
