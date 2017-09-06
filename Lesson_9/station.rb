require_relative 'validation'
# Railways station
class Station
  include Validation
  STATION_FORMAT = /^[A-Z][a-z]{2}$/i

  @stations = []
  attr_reader :name

  class << self
    attr_accessor :stations

    def all
      self.class.stations
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    self.class.stations << self
  end

  def trains(type)
    return nil if @trains.empty?
    if type == 'Passenger'
      @trains.select { |train| train.instance_of? PassengerTrain }
    elsif type == 'Cargo'
      @trains.select { |train| train.instance_of? CargoTrain }
    end
  end

  def arrival(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end

  def each_train
    if block_given?
      @trains.each do |train|
        yield train
      end
    else
      puts 'No block given'
    end
  end
end
