products = {}

# busket = {}

loop do
  puts 'Введите название товара:'
  name = gets.chomp
  break if name == 'стоп'
  puts 'Введите цену за единицу:'
  cost = gets.chomp.to_f
  puts 'Введите количество купленного товара:'
  count = gets.chomp.to_f

  # busket[cost] = count
  products[name] = { cost => count }
end

sum = 0

products.each do |product, details|
  print "Наименование товара #{product}, "
  details.each do |cost, count|
    sum_per_product = cost * count
    print "цена за товар всего: #{sum_per_product.round(2)} \n"
    sum += sum_per_product
  end
end

puts "Цена всего: #{sum.round(2)}"