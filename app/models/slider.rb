class Slider
  include Mongoid::Document

  field :caption, type: String
  field :order, type: Integer
  field :image, type: String
  field :url, type: String

  validates_presence_of :image, :caption

  attr_accessible :image, :caption, :order, :remove_image, :url

  mount_uploader :image, SliderImageUploader
end
