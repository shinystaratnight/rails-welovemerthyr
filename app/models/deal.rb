class Deal
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  STATUSES = %w(unapproved approved)

  field :title, type: String
  field :description, type: String
  field :image, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :status, type: String, default: STATUSES[0]

  belongs_to :business, inverse_of: :deal, class_name: 'Business'

  validates_presence_of :title, :business_id
  validates_inclusion_of :status, in: STATUSES

  attr_accessible :title, :description, :start_date, :end_date, :status, :business_id,
                  :image, :remove_image

  mount_uploader :image, DealImageUploader
end
