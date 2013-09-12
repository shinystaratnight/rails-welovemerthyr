class Business
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  include Mongoid::Taggable

  DEFAULT_TOWN = 'Merthyr Tydfil'
  CATEGORIES   = ['Shopping', 'Eating and Drinking', 'Services', 'Things To Do', 'Places To Stay']
  DAYS         = %w(monday tuesday wednesday thursday friday saturday sunday)
  TIMES        = %w(closed 12am 12.30am 1am 1.30am 2am 2.30am 3am 3.30am 4am 4.30am 5am 5.30am
                    6am 6.30am 7am 7.30am 8am 8.30am 9am 9.30am 10am 10.30am 11am 11.30am
                    12pm 12.30pm 1am 1.30pm 2pm 2.30pm 3pm 3.30pm 4pm 4.30pm 5pm 5.30pm
                    6pm 6.30pm 7pm 7.30pm 8pm 8.30pm 9pm 9.30pm 10pm 10.30pm 11pm 11.30pm)

  field :name, type: String
  field :category, type: String
  field :contact, type: String
  field :address, type: String
  field :town, type: String, default: DEFAULT_TOWN
  field :postcode, type: String
  field :telephone, type: String
  field :website, type: String
  field :email, type: String
  field :twitter, type: String
  field :facebook, type: Boolean
  field :services, type: String
  field :profile, type: String
  field :photo, type: String
  field :coordinates, type: Array

  DAYS.each do |d|
    %w(opening closing).each do |t|
      field "#{d}_#{t}", type: String, default: TIMES[0]
    end
  end

  validates_presence_of :name, :category
  validates_uniqueness_of :name, case_sensitive: false

  attr_accessible :name, :category, :contact, :address, :town, :postcode, :telephone, :website, :email,
                  :twitter, :facebook, :services, :profile, :photo, :remove_photo,
                  :monday_opening, :monday_closing, :tuesday_opening, :tuesday_closing,
                  :wednesday_opening, :wednesday_closing, :thursday_opening,
                  :thursday_closing, :friday_opening, :friday_closing, :saturday_opening,
                  :saturday_closing, :sunday_opening, :sunday_closing

  geocoded_by :address
  after_validation :geocode, if: ->{ address_changed? }

  mount_uploader :photo, BusinessPhotoUploader

  def lat
    coordinates && coordinates[1]
  end

  def lon
    coordinates && coordinates[0]
  end
end
