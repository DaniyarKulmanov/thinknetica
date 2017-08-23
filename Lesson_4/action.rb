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
      user_input 'Введите название станции(как минимум две):'
      break if @input == 'стоп' && @stations.length >= 1
      @stations << Station.new(@input)
    end
  end

  def create_train
    loop do
      user_input 'Введите название поезда(как минимум один):'
      break if @input == 'стоп'
      puts '1 - Пассажирский поезд', '2 - Грузовой'
      type = gets.chomp.to_i
      @trains << PassengerTrain.new(@input) if type == 1
      @trains << CargoTrain.new(@input) if type == 2
      puts 'Поезд не создан, выберите тип' if type != 1 && type != 2
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
    stations_management route
    # add_middle_stations route
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
    user_input 'Введите номер поезда:', @trains
    puts "Всего вагонов #{@trains[@input.to_i].wagons.length}, сколько добавить?"
    n = gets.chomp.to_i
    n.times do
      if @trains[@input.to_i].instance_of? PassengerTrain
        @trains[@input.to_i].add_wagon PassengerWagon.new 'PassengerWagon'
      else
        @trains[@input.to_i].add_wagon CargoWagon.new 'CargoWagon'
      end
    end
  end

  def train_del_wagon
    user_input 'Введите номер поезда:', @trains
    puts "Всего вагонов #{@trains[@input.to_i].wagons.length}, сколько удалить?"
    n = gets.chomp.to_i
    n.times do
      @trains[@input.to_i].del_wagon @trains[@input.to_i].wagons.last
    end
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
    puts 'Список станций:'
    list @stations
    puts 'Список маршрутов:'
    list_routes
  end

  def create_test_data
    5.times do |n|
      @stations << Station.new("Station#{n}")
    end
    @trains << PassengerTrain.new("PASS_TRAIN")
    @trains << CargoTrain.new("CARGO_TRAIN")
    @routes << Route.new(@stations[0], @stations[-1])
    stations_management@routes[0]
    all_trains_and_stations
  end

  private

  def list(array)
    array.each_with_index do |value, index|
      puts "#{index} - #{value.name}"
    end
  end

  def stations_management(route)
    stations = @stations
    stations.delete_at 0
    stations.delete_at '-1'.to_i
    loop do
      user_input 'Выберите промежуточную станцию(стоп - ВЫХОД):', stations
      break if @input == 'стоп'
      puts '1 - добавить стнацию', '2 - удалить станцию'
      operation = gets.chomp.to_i
      if operation == 1
        route.add_station(stations[@input.to_i]) unless stations[@input.to_i].nil?
      elsif operation == 2
        route.del_station(stations[@input.to_i]) unless stations[@input.to_i].nil?
      else
        puts 'Введите 1 или 2'
        next
      end
      list_routes
      stations.delete_at @input.to_i
      break if stations.empty?
    end
  end

  def list_routes
    @routes.each_with_index do |route, index|
      puts "Маршрут № #{index}"
      route.stations.each { |station| puts station.name }
    end
  end

  def user_input(text, array = [])
    puts text
    list array
    @input = gets.chomp
  end

end