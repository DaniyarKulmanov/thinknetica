# Railways station
class Station
  STATION_FORMAT = /^[A-Z][a-z]{2}$/i

  class << self; attr_accessor :stations end
  @stations = []
  attr_reader :name

  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.stations << self
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

  def each_train
    if block_given?
      @trains.each do |train|
        yield train
      end
    else
      puts 'No block given'
    end
  end

  class << self
    def all
      self.class.stations
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
