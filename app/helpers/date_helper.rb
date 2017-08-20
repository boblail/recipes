module DateHelper

  def days_ago_in_words(date)
    distance_in_days = (Date.today - date).to_i
    case distance_in_days
    when 0 then "today"
    when 1 then "yesterday"
    when 2..10 then "#{distance_in_days} days ago"
    else "#{time_ago_in_words(date)} ago"
    end
  end

end
