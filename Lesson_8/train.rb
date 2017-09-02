require_relative 'wagons'
require_relative 'produce_company'

# Railway train
class Train
  @@trains = []
  attr_reader :name, :wagons, :speed, :number
  include ProduceCompany
  include InstanceCounter

  NAME_FORMAT = /^\S[\d a-z A-Z]*$/i
  NUMBER_FORMAT = /^[\d a-z A-Z]{3}[_-]?[\d a-z A-Z]{2}$/i

  def initialize(name, number)
    @name = name
    @number = number
    validate!
    @wagons = []
    @speed  = 0
    @@trains << self
    register_instance
  end

  def add_route(route)
    @route = route
    @station_index = 0
    @route.stations[@station_index].arrival(self)
  end

  def speed_up
    return if @route.nil?
    speed! 1
  end

  def speed_down
    speed! '-1'.to_i
  end

  def full_stop
    speed_down while @speed > 0
  end

  def add_wagon(wagon)
    full_stop
    @wagons << wagon
  end

  def del_wagon(wagon)
    full_stop
    @wagons.delete(wagon)
  end

  def move_forward
    return if @route.stations[@station_index + 1].nil?
    departure_and_arrival 1
  end

  def move_back
    return if @station_index <= 0
    departure_and_arrival '-1'.to_i
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

  def self.find(number)
    puts (@@trains.select { |train| train.number == number })
  end

  # train1.information { |train| puts train.name }
  def each_wagon
    if block_given?
      @wagons.each do |wagon|
        yield wagon
      end
    else
      puts 'No block given'
    end
  end

  protected

  # все поезда имеют максимальную скорость
  def max_speed
    70
  end

  # DRY для публичных методов speed_up / speed_down
  # Пассажирский и грузовые поезда набирают скорость по разному
  def speed!(modifier)
    n = 10 * modifier
    @speed += n if (@speed + n) <= max_speed && (@speed + n) >= 0
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  # DRY move_forward / move_back
  # Принцип перемещения между станциями у поездов одинаков
  def departure_and_arrival(n)
    return if @route.nil?
    return if @speed.zero?
    @route.stations[@station_index].departure(self)
    @station_index += n
    @route.stations[@station_index].arrival(self)
  end

  # DRY для публичных методов *_station
  # Индекс станции есть у всех поездов
  def station(index)
    @route.stations[index]
  end

  protected

  def validate!
    raise 'Имя поезда не верный формат' if @name !~ NAME_FORMAT
    raise 'Номер поезда не верный формат' if @number !~ NUMBER_FORMAT
    true
  end

end