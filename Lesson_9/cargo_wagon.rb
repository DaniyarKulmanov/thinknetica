require_relative 'wagon'
# Cargo wagons
class CargoWagon < Wagon
  attr_reader :volume_all

  def initialize(volume)
    @volume_all = volume
    super 'Cargo'
    @volume_occupied = 0
  end

  def occupy_volume(volume)
    return if @volume_all <= 0
    @volume_all -= volume
    @volume_occupied += volume
  end

  def occupied_volume
    @volume_occupied
  end

  def free_volume
    @volume_all
  end
end
