# Класс вагоны
class Wagon
  attr_reader :type

  def initialize(type)
    @type = type
  end
end

class PassengerWagon < Wagon

end

class CargoWagon < Wagon

end