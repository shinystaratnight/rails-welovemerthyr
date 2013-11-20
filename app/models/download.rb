class Download
  include Mongoid::Document

  field :title, type: String
  field :file, type: String

  attr_accessible :title, :file, :remove_file

  mount_uploader :file, DownloadUploader
end
