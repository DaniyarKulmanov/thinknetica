puts 'Введите основание треугольника:'
a = gets.chomp.to_f

puts 'Введите высоту треугольника:'
h = gets.chomp.to_f

area = 1.0 / 2.0 * a * h
print "Площадь треугольника = #{area}!"
