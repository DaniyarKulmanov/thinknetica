array_fibonacci = []

random_num = Random.new

def formula(n)
  if n >= 3
    formula(n - 1) + formula(n - 2)
  else
    1
  end
end

n = 1

until formula(n) > random_num.rand(100..10_000)
  array_fibonacci << formula(n)
  n += 1
end

puts array_fibonacci