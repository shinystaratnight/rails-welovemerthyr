class Event
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  include Mongoid::MultiParameterAttributes

  field :name, type: String
  field :description, type: String
  field :starts, type: DateTime
  field :ends, type: DateTime
  field :location_name, type: String
  field :location_address, type: String
  field :image, type: String
  field :coordinates, type: Array

  validates_presence_of :name

  attr_accessible :name, :description, :starts, :ends, :location_name, :location_address,
                  :image, :remove_image

  geocoded_by :location_address
  after_validation :geocode, if: ->{ location_address_changed? }

  mount_uploader :image, EventImageUploader

  scope :upcoming, ->(limit) { Event.where(:starts.gte => Time.now).asc(:starts).limit(limit) }

  def lat
    coordinates && coordinates[1]
  end

  def lon
    coordinates && coordinates[0]
  end
end
