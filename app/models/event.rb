class Event
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  include Mongoid::MultiParameterAttributes
  include Mongoid::Slug
  include Mongoid::Timestamps

  paginates_per 6

  field :name, type: String
  field :description, type: String
  field :starts, type: DateTime
  field :ends, type: DateTime
  field :location_name, type: String
  field :location_address, type: String
  field :image, type: String
  field :coordinates, type: Array

  slug :name

  validates_presence_of :name
  validate :starts_ends

  attr_accessible :name, :starts, :ends, :location_name, :location_address,
                  :image, :remove_image, :description

  geocoded_by :location_address
  after_validation :geocode, if: ->{ location_address_changed? }

  mount_uploader :image, EventImageUploader

  scope :upcoming, ->(limit) { Event.where(:starts.gte => Time.now).asc(:starts).limit(limit) }
  scope :not_ending, ->(limit) { Event.where(:ends.gt => Date.today.beginning_of_day).asc(:starts).limit(limit) }
  scope :upcoming_ongoing, ->(limit) { Event.where(:ends.gte => Time.now).asc(:starts).limit(limit) }
  scope :newest, desc(:created_at)

  def lat
    coordinates && coordinates[1]
  end

  def lon
    coordinates && coordinates[0]
  end

private

  def starts_ends
    errors.add(:ends, 'Must be after start date') if ends <= starts
  end
end
