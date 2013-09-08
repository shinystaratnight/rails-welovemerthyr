class Business < ActiveRecord::Base
  CATEGORIES = ['Shopping', 'Eating and Drinking', 'Services', 'Things To Do', 'Places To Stay']

  DEFAULT_TOWN = 'Merthyr Tydfil'

  # WeeklySchedule will be destroyed if its Business is destroyed.
  #
  has_one :weekly_schedule, dependent: :destroy

  # Only +name+ and +category+ fields are mandatory.
  #
  validates_presence_of :name, :category
  validates_uniqueness_of :name, case_sensitive: false
  validates_inclusion_of :category, in: CATEGORIES

  # Mass-assignments.
  #
  attr_accessible :name, :category, :address, :town, :postcode, :telephone, :website, :email,
                  :twitter, :facebook, :service_list, :profile, :weekly_schedule_attributes,
                  :photo, :remove_photo, :contact, :services

  # Delegate attributes to weekly_schedule in order to
  # call them directly from a Business instance.
  # (Law of Demeter, one dot at a time)
  #
  delegate :monday_opening, :monday_closing, :tuesday_opening, :tuesday_closing,
           :wednesday_opening, :wednesday_closing, :thursday_opening,
           :thursday_closing, :friday_opening, :friday_closing, :saturday_opening,
           :saturday_closing, :sunday_opening, :sunday_closing,
           to: :weekly_schedule

  # Required in order to have WeeklySchedule get saved after saving Business.
  #
  accepts_nested_attributes_for :weekly_schedule

  # Taggable on +services+ field.
  #
  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :services

  # Get geolocation using Geocoder by +address+ field.
  # Update longitude, latitude only if address got changed.
  #
  geocoded_by :address, latitude: :lat, longitude: :lon
  after_validation :geocode, if: ->{ address_changed? }

  after_validation :set_default_town

  mount_uploader :photo, BusinessPhotoUploader

private

  def set_default_town
    town.blank? && self.town = DEFAULT_TOWN
  end
end
