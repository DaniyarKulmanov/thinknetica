require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagons'

# work with input data
class Action
  attr_reader :routes, :stations, :trains

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def create_station
    loop do
      puts 'Введите название станции(как минимум две):'
      station = gets.chomp
      break if station == 'стоп' && @stations.length >= 1
      @stations << Station.new(station)
    end
  end

  def create_train
    loop do
      puts 'Введите название поезда(как минимум один):'
      train = gets.chomp
      break if train == 'стоп'
      @trains << Train.new(train)
    end
  end

  def create_route
    return if @stations.empty?
    puts 'Список станций:'
    list @stations
    puts 'Номер начальной станции:'
    first_station = gets.chomp.to_i
    puts 'Номер конечной станции:'
    last_station = gets.chomp.to_i
    route = Route.new(@stations[first_station], @stations[last_station])
    stations = @stations
    stations.delete_at first_station
    stations.delete_at (last_station - 1)
    add_middle_stations route, stations
    @routes << route
    list_routes
  end

  def assign_route_to_train
    puts 'Введите номер поезда:'
    list @trains
    train = gets.chomp.to_i
    puts 'Введите маршрут:'
    list_routes
    route = gets.chomp.to_i
    @trains[train].add_route(@routes[route])
  end

  def train_add_wagon
    puts 'Введите номер поезда:'
    list @trains
    index = gets.chomp.to_i
    puts "Всего вагонов #{@trains[index].wagons.length}, сколько добавить?"
    n = gets.chomp.to_i
    n.times do
      @trains[index].add_wagon Wagon.new 'Simple'
    end
    puts "Всего вагонов #{@trains[index].wagons.length}"
  end

  def train_del_wagon
    puts 'Введите номер поезда:'
    list @trains
    index = gets.chomp.to_i
    puts "Всего вагонов #{@trains[index].wagons.length}, сколько удалить?"
    n = gets.chomp.to_i
    n.times do
      @trains[index].del_wagon @trains[index].wagons.last
    end
    puts "Всего вагонов #{@trains[index].wagons.length}"
  end

  def move_train
    puts 'Введите номер поезда:'
    list @trains
    index = gets.chomp.to_i
    @trains[index].speed_up
    @trains[index].move_forward
  end

  def all_trains_and_stations
    puts 'Список поездов:'
    list @trains
    puts 'Список станций'
    list @stations
  end

  private

  def list(array)
    array.each_with_index do |value, index|
      puts "#{index} - #{value.name}"
    end
  end

  def add_middle_stations(route, stations)
    loop do
      puts 'Выберите станцию:'
      list @stations
      index = gets.chomp.to_i
      route.add_station(stations[index])
      stations.delete_at index
      break if stations.empty?
    end
  end

  def list_routes
    @routes.each_with_index do |route, index|
      puts "Маршрут № #{index}"
      route.stations.each { |station| puts station.name }
    end
  end

end

action = Action.new

loop do
  puts 'Выберите действия(введите "стоп" для выхода):',
       '1 - Создать станцию',
       '2 - Создать поезд',
       '3 - Создать маршрут, добавить или удалить станцию в маршрут',
       '4 - Назначить маршрут поезду',
       '5 - Добавить вагон',
       '6 - Добавить отцепить вагон',
       '7 - Перемещение поезда',
       '8 - Просмотреть список станций и поездов'
  command = gets.chomp
  break if command == 'стоп'

  case command
  when '1'then action.create_station
  when '2'then action.create_train
  when '3'then action.create_route
  when '4'then action.assign_route_to_train
  when '5'then action.train_add_wagon
  when '6'then action.train_del_wagon
  when '7'then action.move_train
  when '8'then action.all_trains_and_stations
  else
    puts 'Введите число от 1 до 8'
  end
end






