puts 'Введите своё имя:'
name = gets.chomp
puts 'Введите свой рост:'
height = gets.chomp

if (ideal_weight = height.to_i - 110) > 0
  puts "#{name} Ваш идеальный вес = #{ideal_weight}"
else
  puts 'Ваш вес уже оптимальный!'
end