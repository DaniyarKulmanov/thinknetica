puts 'Введите год:'
year = gets.chomp.to_i

puts 'Введите месяц:'
month = gets.chomp.to_i

puts 'Введите день:'
day = gets.chomp.to_i

leap_year = false

if (year == 2000 || (year % 400).zero?) || ((year % 4).zero? && !(year % 100).zero?)
  puts 'Високосный год'
  leap_year = true if month > 2
else
  puts 'Не високосный год'
end

days_of_month = 0
days_of_month += 1 if leap_year

if month == 1
  days_of_month = day
else
  (1..(month - 1)).each do |mon|
    days = 28 + (mon + (mon / 8)) % 2 + 2 % mon + 2 * (1 / mon)
    days_of_month += days
  end
  days_of_month += day
end

puts "Номер дня в году = #{days_of_month}"