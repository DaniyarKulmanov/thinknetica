require_relative 'produce_company'
# Класс вагоны
class Wagon
  attr_reader :type
  include ProduceCompany
  def initialize(type)
    @type = type
  end
end