class Slider
  include Mongoid::Document
  include Mongoid::Timestamps

  field :caption, type: String
  field :order, type: Integer
  field :image, type: String
  field :url, type: String

  validates_presence_of :image

  attr_accessible :image, :caption, :order, :remove_image, :url

  mount_uploader :image, SliderImageUploader

  scope :newest, desc(:created_at)
end
