class Slider
  include Mongoid::Document

  field :caption, type: String
  field :order, type: Integer
  field :image, type: String

  validates_presence_of :image, :caption

  attr_accessible :image, :caption, :order, :remove_image

  mount_uploader :image, SliderImageUploader
end
