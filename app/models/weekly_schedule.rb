class WeeklySchedule < ActiveRecord::Base
  DAYS = %w(monday tuesday wednesday thursday friday saturday sunday)

  TIMES = %w(12am 12h30am 1am 1h30am 2am 2h30am 3am 3h30am 4am 4h30am 5am 5h30am
             6am 6h30am 7am 7h30am 8am 8h30am 9am 9h30am 10am 10h30am 11am 11h30am
             12pm 12h30pm 1am 1h30pm 2pm 2h30pm 3pm 3h30pm 4pm 4h30pm 5pm 5h30pm
             6pm 6h30pm 7pm 7h30pm 8pm 8h30pm 9pm 9h30pm 10pm 10h30pm 11pm 11h30pm)

  belongs_to :business

  attr_accessible :monday_opening, :monday_closing, :tuesday_opening, :tuesday_closing,
                  :wednesday_opening, :wednesday_closing, :thursday_opening,
                  :thursday_closing, :friday_opening, :friday_closing, :saturday_opening,
                  :saturday_closing, :sunday_opening, :sunday_closing

end
