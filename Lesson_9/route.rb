require_relative 'validation'
# Railway routes
class Route
  include Validation
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
