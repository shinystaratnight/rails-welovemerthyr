class Business < ActiveRecord::Base
  KINDS = ['Shopping', 'Eating and Drinking', 'Services', 'Things To Do', 'Places To Stay']

  has_one :weekly_schedule, dependent: :destroy

  validates_presence_of :name, :kind

  attr_accessible :name, :kind, :address, :town, :postcode, :telephone, :website, :email,
                  :twitter, :facebook, :services, :profile, :weekly_schedule_attributes

  delegate :monday_opening, :monday_closing, :tuesday_opening, :tuesday_closing,
            :wednesday_opening, :wednesday_closing, :thursday_opening,
            :thursday_closing, :friday_opening, :friday_closing, :saturday_opening,
            :saturday_closing, :sunday_opening, :sunday_closing,
            to: :weekly_schedule

  accepts_nested_attributes_for :weekly_schedule
end
