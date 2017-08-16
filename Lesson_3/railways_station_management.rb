# Railways station
class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains(type)
    if @trains.empty?
      puts 'No trains in station'
    else
      @trains.select { |train| train.type == type }
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

  def initialize(station_from, station_to)
    @stations = [station_from, station_to]
  end

  def add_station(station)
    @stations.insert(- 2, station)
  end

  def del_station(station)
    @stations.delete(station)
  end
end

# Railway train
class Train
  attr_reader :codename, :type, :wagons, :speed

  def initialize(codename, type, wagons)
    @codename = codename
    @type = type
    @wagons = wagons
    @speed  = 0
    # @route = nil
  end

  def current_speed
    puts "Current speed is #{@speed}"
  end

  def speed_up(value)
    if value >= 0
      @speed += value
      current_speed
    else
      puts 'Enter positive value'
    end
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
    elsif @wagons > 0
      @wagons -= 1
    else
      puts 'No wagons to subtract'
    end
  end

  def add_route(route)
    @route = route
    @station_index = 0
  end

  def move_forward
    if @route.stations[@station_index].nil? && @route.nil?
      puts 'No route or last station reached'
    elsif !@route.stations[@station_index + 1].nil?
      departure_and_arrival 1
    else
      puts 'Cannot move forward last station reached'
    end
  end

  def move_back
    if @route.stations[@station_index].nil? && @route.nil?
      puts 'No route or first station reached'
    elsif !@route.stations[@station_index - 1].nil? && @station_index > 0
      departure_and_arrival -1
    else
      puts 'Cannot move back first station reached'
    end
  end

  def current_station
    station(@station_index)
  end

  def next_station
    station(@station_index + 1)
  end

  def previous_station
    station(@station_index - 1) if @station_index > 0
  end

  private

  def departure_and_arrival(n)
    @route.stations[@station_index].departure(self)
    @station_index += n
    @route.stations[@station_index].arrival(self)
  end

  def station(index)
    @route.stations[index]
  end
end