class Deal
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include Mongoid::Slug

  STATUSES = %w(unapproved approved)

  paginates_per 7

  field :title, type: String
  field :description, type: String
  field :image, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :status, type: String, default: STATUSES[0]
  field :terms, type: String

  slug :title

  belongs_to :business, inverse_of: :deal, class_name: 'Business'

  validates_presence_of :title, :business_id
  validates_inclusion_of :status, in: STATUSES

  attr_accessible :title, :description, :start_date, :end_date, :status, :business_id,
                  :image, :remove_image, :terms

  delegate :name, to: :business, prefix: 'business'

  mount_uploader :image, DealImageUploader

  scope :latest, ->(limit) { Deal.where({}).desc(:created_at).limit(limit) }
  scope :approved, -> { Deal.where(status: STATUSES[1]) }

  def unapproved?
    status == STATUSES[0]
  end
end
