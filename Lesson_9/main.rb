require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'station'
require_relative 'route'
require_relative 'train'

puts '=========================================='
puts 'Creating simple Wagon, with wrong data'

def wagon_validation(object, format, type)
  object.validate!(object.type, format, type) if object.instance_of? Wagon
  object.validate!(object.volume_all, format, type) if object.instance_of? CargoWagon
  object.validate!(object.seats_all, format, type) if object.instance_of? PassengerWagon
rescue RuntimeError => e
  puts e.message
end

puts '1. Empty wagon type:'
wagon = Wagon.new ' '
wagon_validation wagon, Wagon::WAGON_TYPE, String

puts '2. Wrong type format:'
wagon.type = 'Test'
wagon_validation wagon, Wagon::WAGON_TYPE, String

puts '3. Wrong class type:'
wagon.type = 'Cargo'.to_sym
wagon_validation wagon, Wagon::WAGON_TYPE, String

puts '=========================================='
puts 'Creating Cargo wagon, with wrong data'

puts '1. Cargo wagon volume nil:'
wagon = CargoWagon.new ''
wagon_validation wagon, Wagon::WAGON_TYPE, Integer

puts '2. Cargo wagon volume wrong class:'
wagon = CargoWagon.new 'Test'
wagon_validation wagon, Wagon::WAGON_TYPE, Integer

puts '=========================================='
puts 'Creating Passenger wagon, with wrong data'

puts '1. Passenger wagon seats nil:'
wagon = PassengerWagon.new ''
wagon_validation wagon, Wagon::WAGON_TYPE, Integer

puts '2. Passenger wagon volume wrong class:'
wagon = PassengerWagon.new 'Test'
wagon_validation wagon, Wagon::WAGON_TYPE, Integer

puts '=========================================='
puts 'Creating Station, with wrong data'
def station_validation(object, format, type)
  object.validate!(object.name, format, type)
rescue RuntimeError => e
  puts e.message
end

puts '1. Station name nil:'
station = Station.new ''
station_validation station, Station::STATION_FORMAT, String

puts '2. Station name wrong format:'
station = Station.new '22222'
station_validation station, Station::STATION_FORMAT, String

puts '=========================================='
puts 'Creating Route, with wrong data'

def route_validation(object, format, type, n)
  object.validate!(object.stations[n], format, type)
rescue RuntimeError => e
  puts e.message
end

puts '1. Route station nil:'
route = Route.new '', 12
route_validation route, Station::STATION_FORMAT, Station, 0

puts '2. Route station wrong class:'
route = Route.new station, 12
route_validation route, Station::STATION_FORMAT, Station, -1

puts '=========================================='
puts 'Creating Train, with wrong data'

def train_validation(object, format, type, var)
  object.validate!(object.name, format, type) if var == :name
  object.validate!(object.number, format, type) if var == :number
rescue RuntimeError => e
  puts e.message
end

puts '1. Train name nil:'
train = Train.new '', 'SFG-28'
train_validation train, Train::NAME_FORMAT, String, :name

puts '2. Train name wrong format:'
train = Train.new 33, 'SFG-28'
train_validation train, Train::NAME_FORMAT, String, :name

puts '3. Train name wrong class type:'
train = Train.new 'KWA'.to_sym, 'SFG-28'
train_validation train, Train::NAME_FORMAT, String, :name

puts '4. Train number nil:'
train = Train.new 'WIR', ''
train_validation train, Train::NUMBER_FORMAT, String, :number

puts '5. Train number wrong format:'
train = Train.new 'WIR', '872'
train_validation train, Train::NUMBER_FORMAT, String, :number

puts '6. Train name wrong class type:'
train = Train.new 'WIR', 'SFG-28'.to_sym
train_validation train, Train::NUMBER_FORMAT, String, :number
