require_relative 'train'

# Пассажирские поезда
class PassengerTrain < Train

  def add_wagon(wagon)
    super wagon if wagon.instance_of? PassengerWagon
  end

  def del_wagon(wagon)
    super wagon if wagon.instance_of? PassengerWagon
  end

  def move_forward
    wifi_on if previous_station.nil?
    super
    wifi_off if next_station.nil?
  end

  protected

  def max_speed
    100
  end

  def speed!(modifier)
    super modifier * 1.5
  end

  private

  def wifi_on
    @wifi = true
  end

  def wifi_off
    @wifi = false
  end

  def electric_capacity
    3000
  end
end