require_relative 'wagons'

class CargoWagon < Wagon
  attr_reader :volume_all

  def initialize(volume)
    @volume = volume
    begin
      super 'Cargo'
    rescue RuntimeError
      raise 'Volume must be a number'
    end
    @volume_all = { free: volume, occupied: 0 }
  end

  def occupy_volume(volume)
    return if @volume_all[:free] <= 0
    @volume_all[:free] -= volume
    @volume_all[:occupied] += volume
  end

  def occupied_volume
    @volume_all[:occupied]
  end

  def free_volume
    @volume_all[:free]
  end

  private

  def validate! # TODO: create validate module and include in classes
    super
    raise RuntimeError if @volume.class != Integer
    true
  end
end