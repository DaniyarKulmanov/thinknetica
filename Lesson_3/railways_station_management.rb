# Railways station
class Station
  attr_reader :name
  attr_reader :trains
  attr_accessor :parked

  def initialize(name)
    @name = name
    @parked = ''
    @trains = {}
  end

  def arrival(codename, type, wagons)
    train = { type: type, wagons: wagons }
    @trains[codename] = train
    if @parked.empty?
      @parked = codename
    else
      puts "Rejected, there is a parked train #{@parked}"
    end
  end

  def departure
    if @parked != ''
      @trains.delete(@parked)
      puts "Train #{@parked} is departured"
      @parked = ''
    else
      puts 'No train to departure!'
    end
  end
end

# Railway routes
class Route
  attr_reader :stations

  def initialize(st_from, st_to)
    @stations = [st_from, st_to]
  end

  def add_route(st_middle)
    @stations << st_middle
  end

  def del_route(st_del)
    @stations.delete(st_del)
  end

  def stations_list
    puts "First station   #{@stations[0]}"
    @stations.each_with_index do |station, index|
      puts "Middle stations #{station}" if index != 0 && index != 1
    end
    puts "Last station:   #{@stations[1]}"
  end
end

# Railway train
class Train
  attr_reader :train
  def initialize(codename, type, wagons)
    @train = { codename: codename, type: type, wagons: wagons, speed: 0 }
  end

  def current_speed
    puts "Current speed is #{@train[:speed]}"
  end

  def speed_up(value)
    @train[:speed] += value
    current_speed
  end

  def full_stop
    @train[:speed] = 0
    current_speed
  end

  def wagons(wagons)
    if @train[:speed] != 0
      puts 'Stop train first'
      current_speed
    else
      @train[:wagons] += wagons.to_i
    end
  end

  def add_route(route)
    if @train[:route].nil?
       @train[:route] = route
       @train[:current_route] = route.stations[0]
    end
  end

  def route_next
    @train[:current_last_route] = @train[:current_route]
    @train[:current_route] = @train[:route].stations[+1]
    @train[:next_route] = @train[:route].stations[+2]
  end

  def route_back
    @train[:current_last_route] = @train[:current_route]
    @train[:current_route] = @train[:route].stations[-1]
    @train[:next_route] = @train[:route].stations[+1]
  end
end