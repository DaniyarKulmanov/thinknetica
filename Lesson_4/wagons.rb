require_relative 'produce_company'
require_relative 'InstanceCounter'
# Класс вагоны
class Wagon
  attr_reader :type
  include ProduceCompany
  include InstanceCounter
  count_initialize

  def initialize(type)
    @type = type
    register_instance
  end
end