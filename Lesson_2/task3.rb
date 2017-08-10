array_fibonacci = [0, 1]
fibonacci = 0
max = 100

until fibonacci > max
  fibonacci = array_fibonacci[-1] + array_fibonacci[-2]
  array_fibonacci << fibonacci if fibonacci <= max
end

puts array_fibonacci