require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'cargo_train'

stations = []
trains = []
routes = []
wagons = []

def random
  ('A'..'Z').to_a.shuffle.join[0..2]
end

2.times do
  name = random
  stations << Station.new(name.to_s)
end

name = random
trains << PassengerTrain.new(name = name.to_s, "#{name.downcase!}-11")
name = random
trains << CargoTrain.new(name = name.to_s, "#{name.downcase!}-22")
routes << Route.new(stations[0], stations[-1])

10.times do
  passenger_wagon = PassengerWagon.new(rand(20..30))
  wagons << passenger_wagon
  trains[0].add_wagon passenger_wagon
  cargo_wagon = CargoWagon.new(rand(100..150))
  wagons << cargo_wagon
  trains[1].add_wagon cargo_wagon
end

trains.each { |train| train.add_route routes[0] }

puts "Passenger trains at station #{stations[0].name}"
stations[0].each_train do |train|
  puts "Train name:#{train.name}, number:#{train.number}, wagons:#{train.wagons.size}"
end

n = 0
puts '============================================='
puts "Train #{trains[0].name} wagons information:"
trains[0].each_wagon do |wagon|
  n += 1
  puts " Number-#{n}, type-#{wagon.type}, occupied seats:#{wagon.occupied_seats}, free seats:#{wagon.free_seats},"
end

n = 0
puts '============================================='
puts "Train #{trains[1].name} wagons information:"
trains[1].each_wagon do |wagon|
  n += 1
  puts " Number-#{n}, type-#{wagon.type}, occupied volume:#{wagon.occupied_volume}, free volume:#{wagon.free_volume},"
end

