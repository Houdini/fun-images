module ApplicationHelper
  def time_ago_from time_at
    return '' unless time_at
    difference = Time.now - time_at
    if difference < 60
      t :just_now
    elsif difference < FIFTEEN_MINUTES
      return t :minutes_ago
    elsif difference < HOUR
      return t :less_then_hour
#    elsif difference < HOUR*24 and time_at.to_date == Date.today
      # l(:hours_back, :count => difference.to_i/HOUR)
#      l time_at, :format => :default
#    elsif (Date.today - time_at.to_date).to_i < 7
#      return l(:days_back, :count => (Date.today - time_at.to_date).to_i)
#      l time_at, :format => :default
    else
#      p "here: #{l time_at, :format => :date_month}"
      l(time_at.to_date, :format => :date_month)
    end
  end

  def page_title text = nil
    if text
      text
    else
      '7wit'
    end
  end
end
