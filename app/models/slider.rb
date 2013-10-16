class Slider
  include Mongoid::Document

  field :image, type: String
  field :caption, type: String
  field :order, type: Integer

  validates_presence_of :image, :caption

  attr_accessible :image, :caption, :order, :remove_image

  mount_uploader :image, SliderImageUploader
end
