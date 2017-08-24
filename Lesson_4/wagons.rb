require_relative 'produce_company'
require_relative 'InstanceCounter'
# Класс вагоны
class Wagon
  attr_reader :type
  include ProduceCompany
  extend InstanceCounter

  def initialize(type)
    @type = type
    Wagon.count
  end
end