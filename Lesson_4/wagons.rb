require_relative 'produce_company'
require_relative 'InstanceCounter'
# Класс вагоны
class Wagon
  attr_reader :type
  include ProduceCompany
  include InstanceCounter

  def initialize(type)
    @type = type
    Wagon.count
    register_instance
  end
end