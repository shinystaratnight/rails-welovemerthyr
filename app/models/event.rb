class Event
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  field :name, type: String
  field :description, type: String
  field :starts, type: Time
  field :ends, type: Time
  field :location_name, type: String
  field :location_address, type: String
  field :longitude, type: Float
  field :latitude, type: Float
  field :image, type: String

  validates_presence_of :name

  attr_accessible :name, :description, :starts, :ends, :location_name, :location_address,
                  :image, :remove_image

  geocoded_by :location_address#, latitude: :lat, longitude: :lon
  after_validation :geocode, if: ->{ location_address_changed? }

  mount_uploader :image, EventImageUploader
end
