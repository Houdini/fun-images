module ApplicationHelper
  def time_ago_from time_at
    return '' unless time_at
    difference = Time.now - time_at
    if difference < 60
      return t :just_now
    elsif difference < FIFTEEN_MINUTES
      return t :minutes_ago
    elsif difference < HOUR
      return t :less_then_hour
    else
      return l(time_at, :format => :default)
    end
  end
end
