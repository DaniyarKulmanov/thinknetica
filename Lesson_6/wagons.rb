require_relative 'produce_company'
require_relative 'InstanceCounter'
# Класс вагоны
class Wagon
  attr_accessor :type
  include ProduceCompany
  include InstanceCounter

  WAGON_TYPE = /Passenger|Cargo/

  def initialize(type)
    @type = type
    register_instance
  end

end