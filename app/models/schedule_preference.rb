class SchedulePreference < ActiveRecord::Base
  belongs_to User

  # Ored number of weekdays to store preference
  @week = 0000000

  module Weekday
    SUNDAY    = 1 << 0
    MONDAY    = 1 << 1
    TUESDAY   = 1 << 2
    WEDNESDAY = 1 << 3
    THURSDAY  = 1 << 4
    FRIDAY    = 1 << 5
    SATURDAY  = 1 << 6
  end
end
