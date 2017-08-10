puts 'для проверки прямоугольного треугольника введите 7, 7, 9.899494936611665'
puts 'Введите длину 1 сторону треугольника:'
a = gets.chomp.to_f

puts 'Введите длину 1 сторону треугольника:'
b = gets.chomp.to_f

puts 'Введите длину 3 сторону треугольника:'
c = gets.chomp.to_f

triangle = [a, b, c]

# Hypotenuse
triangle.sort
a = triangle[0]
b = triangle[1]
h = triangle[2]

# pryamougolniy
puts 'Прямоугольный треугольник!' if h**2 == (a**2 + b**2)

# ravnobedreniy
puts 'Ваш треугольник равнобедренный!' if a == b || b == c || a == c

# ravnobedreniy
puts 'Ваш треугольник равносторонний!' if a == b && b == c
