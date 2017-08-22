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
    puts "#{train.name}, arrived at station #{@name}"
  end

  def departure(train)
    @trains.delete(train)
    puts "#{train.name}, departed from station #{@name}"
  end
end