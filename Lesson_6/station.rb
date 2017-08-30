# Railways station
class Station
  @@stations = []
  attr_reader :name

  STATION_FORMAT = /^[A-Z][a-z]{2}$/i

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
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
    puts "#{train.name}, arrived at station #{@name}"
  end

  def departure(train)
    @trains.delete(train)
    puts "#{train.name}, departed from station #{@name}"
  end

  class << self
    def all
      @@stations
    end
  end
end