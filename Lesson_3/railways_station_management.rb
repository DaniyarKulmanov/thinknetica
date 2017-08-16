# Railways station
class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains(type)
    if @trains.nil?
      puts 'No trains in station'
    else
      @trains.select{ |train| train.type == type }
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

  def add_station(st_middle)
    @stations.insert((@stations.length - 1), st_middle)
  end

  def del_route(st_del)
    @stations.delete(st_del)
  end

  def stations_list
    @stations.each { |station| puts station.name }
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
    @station = 0
  end

  def move_forward
    if @route.stations[@station].nil? && @route.nil?
      puts 'No route or last station reached'
    elsif !@route.stations[@station + 1].nil?
      @station += 1
    else
      puts 'Cannot move forward last station reached'
    end
  end

  def move_back
    if @route.stations[@station].nil? && @route.nil?
      puts 'No route or first station reached'
    elsif !@route.stations[@station - 1].nil? && @station > 0
      @station -= 1
    else
      puts 'Cannot move back first station reached'
    end
  end

  def current_station
    puts "Last station = #{@route.stations[@station - 1].name}" if @station > 0
    puts "Current station = #{@route.stations[@station].name}"
    if !@route.stations[@station + 1].nil?
      puts "Next station = #{@route.stations[@station + 1].name}"
    else
      puts 'No next station'
    end
  end
end