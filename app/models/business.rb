class Business
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  include Mongoid::Taggable

  DEFAULT_TOWN = 'Merthyr Tydfil'
  CATEGORIES   = ['Shopping', 'Eating and Drinking', 'Services', 'Things To Do', 'Places To Stay']
  DAYS         = %w(monday tuesday wednesday thursday friday saturday sunday)
  TIMES        = %w(12am 12h30am 1am 1h30am 2am 2h30am 3am 3h30am 4am 4h30am 5am 5h30am
                    6am 6h30am 7am 7h30am 8am 8h30am 9am 9h30am 10am 10h30am 11am 11h30am
                    12pm 12h30pm 1am 1h30pm 2pm 2h30pm 3pm 3h30pm 4pm 4h30pm 5pm 5h30pm
                    6pm 6h30pm 7pm 7h30pm 8pm 8h30pm 9pm 9h30pm 10pm 10h30pm 11pm 11h30pm)

  field :name, type: String
  field :category, type: String
  field :contact, type: String
  field :address, type: String
  field :town, type: String
  field :postcode, type: String
  field :telephone, type: String
  field :website, type: String
  field :email, type: String
  field :twitter, type: String
  field :facebook, type: Boolean
  field :services, type: String
  field :profile, type: String
  field :photo, type: String
  field :lat, type: Float
  field :lon, type: Float
  field :coordinates, type: Array

  field :monday_opening, type: String
  field :monday_closing, type: String
  field :tuesday_opening, type: String
  field :tuesday_closing, type: String
  field :wednesday_opening, type: String
  field :wednesday_closing, type: String
  field :thursday_opening, type: String
  field :thursday_closing, type: String
  field :friday_opening, type: String
  field :friday_closing, type: String
  field :saturday_opening, type: String
  field :saturday_closing, type: String
  field :sunday_opening, type: String
  field :sunday_closing, type: String

  validates_presence_of :name, :category
  validates_uniqueness_of :name, case_sensitive: false

  attr_accessible :name, :category, :contact, :address, :town, :postcode, :telephone, :website, :email,
                  :twitter, :facebook, :services, :profile, :photo, :remove_photo,
                  :monday_opening, :monday_closing, :tuesday_opening, :tuesday_closing,
                  :wednesday_opening, :wednesday_closing, :thursday_opening,
                  :thursday_closing, :friday_opening, :friday_closing, :saturday_opening,
                  :saturday_closing, :sunday_opening, :sunday_closing

  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: ->{ address_changed? }

  after_validation :set_default_town

  mount_uploader :photo, BusinessPhotoUploader

private

  def set_default_town
    town.blank? && self.town = DEFAULT_TOWN
  end

end
