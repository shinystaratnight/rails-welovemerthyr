class BusinessCategoryTemplate
  include Mongoid::Document

  field :category, type: String
  field :body, type: String
  field :image, type: String

  attr_accessible :category, :body, :image, :remove_image

  validates_presence_of :category, :body, :image
  validates_uniqueness_of :category

  mount_uploader :image, BusinessCategoryTemplateImageUploader
end
