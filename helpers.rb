def minutes_between(start_time, end_time)
  difference_seconds = (end_time - start_time).to_i

  difference_minutes = difference_seconds / 60

  difference_minutes
end