module ApplicationHelper
  def time_difference_in_words(from_time, to_time)
    difference = TimeDifference.between(from_time, to_time)
    if to_time - from_time < 59.seconds
      value = difference.in_seconds.round
      unit = "second"
    elsif to_time - from_time < 59.minutes
      value = difference.in_minutes.round
      unit = "minute"
    elsif to_time - from_time < 24.hours
      value = difference.in_hours.round
      unit = "hour"
    elsif to_time - from_time < 7.days
      value = difference.in_hours.round
      unit = "day"
    elsif to_time - from_time < 4.weeks
      value = difference.in_weeks.round
      unit = "week"
    elsif to_time - from_time < 12.months
      value = difference.in_months.round
      unit = "month"
    else
      value = difference.in_years.round
      unit = "year"
    end
    "#{value} #{unit}#{value != 1 ? "s" : ""} ago"
  end
end
