# Railway routes
class Route
  attr_reader :stations

  def initialize(station_from, station_to)
    @stations = [station_from, station_to]
    validate!
  end

  def add_station(station)
    @stations.insert(- 2, station)
  end

  def del_station(station)
    @stations.delete(station)
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    raise 'Fill first station' if @stations[0].empty?
    raise 'Fill last stations' if @stations[-1].empty?
    true
  end

end