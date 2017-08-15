# Railways station
class Station
  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def trains_by_type
    @trains.each do |train|
      puts "#{train.codename} type #{train.type}"
    end
  end

  def arrival(train)
    @trains << train
    puts "#{train.codename}, arrived"
  end

  def departure(train)
    @trains.delete(train)
    puts "#{train.codename}, departed"
  end
end

# Railway routes
class Route
  attr_reader :stations

  def initialize(st_from, st_to)
    @stations = [st_from, st_to]
  end

  def add_route(st_middle)
    @stations.insert((@stations.length - 1), st_middle)
  end

  def del_route(st_del)
    @stations.delete(st_del)
  end

  def stations_list
    @stations.each { |station| puts station.station_name }
  end
end

# Railway train
class Train
  attr_reader :codename, :type, :wagons, :speed

  def initialize(codename, type, wagons)
    # @attributes = { codename: codename, type: type, wagons: wagons, speed: 0 }
    @codename = codename
    @type = type
    @wagons = wagons
    @speed  = 0
  end

  def current_speed
    puts "Current speed is #{@speed}"
  end

  def speed_up(value) # TODO
    @speed += value
    current_speed
  end

  def full_stop
    @speed = 0
    current_speed
  end

  def add_wagon
    if @speed != 0
      puts 'Stop train first'
      current_speed
    else
      @wagons += 1
    end
  end

  def del_wagon
    if @speed != 0
      puts 'Stop train first'
      current_speed
    else
      @wagons -= 1
    end
  end

  # def add_route(route)
  #   if @attributes[:route].nil?
  #      @attributes[:route] = route
  #      @attributes[:current_route] = route.stations[0]
  #   end
  # end
  #
  # def route_next
  #   @train[:current_last_route] = @train[:current_route]
  #   @train[:current_route] = @train[:route].stations[+1]
  #   @train[:next_route] = @train[:route].stations[+2]
  # end
  #
  # def route_back
  #   @train[:current_last_route] = @train[:current_route]
  #   @train[:current_route] = @train[:route].stations[-1]
  #   @train[:next_route] = @train[:route].stations[+1]
  # end
end