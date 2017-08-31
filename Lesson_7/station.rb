# Railways station
class Station
  @@stations = []
  attr_reader :name

  STATION_FORMAT = /^[A-Z][a-z]{2}$/i

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
  end

  def trains(type)
    if @trains.empty?
      nil
    else
      @trains.select { |train| train.type == type }
    end
  end

  def arrival(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end

  class << self
    def all
      @@stations
    end
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    raise 'Station invalid format' if @name !~ STATION_FORMAT
    true
  end
end