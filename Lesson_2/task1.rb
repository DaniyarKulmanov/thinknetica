require 'date'

months_days = {}

(1..12).each do |month|
  month_name = Date.parse("01.#{month}.2017").strftime('%B')
  days = Date.new(2017, month, -1).day
  months_days[month_name.to_sym] = days
  puts "#{month_name} has #{days}" if days == 30
end