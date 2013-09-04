class WeeklySchedule < ActiveRecord::Base
  DAYS = %w(monday tuesday wednesday thursday friday saturday sunday)

  belongs_to :business

  attr_accessible :monday_opening, :monday_closing, :tuesday_opening, :tuesday_closing,
                  :wednesday_opening, :wednesday_closing, :thursday_opening,
                  :thursday_closing, :friday_opening, :friday_closing, :saturday_opening,
                  :saturday_closing, :sunday_opening, :sunday_closing

end
