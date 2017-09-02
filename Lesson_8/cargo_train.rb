require_relative 'train'

# Cargo Trains
class CargoTrain < Train
  def add_wagon(wagon)
    super wagon if wagon.instance_of? CargoWagon
  end

  def del_wagon(wagon)
    super wagon if wagon.instance_of? CargoWagon
  end

  protected

  def max_speed
    60
  end

  def speed!(modifier)
    super modifier * 0.8
  end

  private

  def pull_power
    450
  end
end
