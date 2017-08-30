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
    begin
      validate!
    rescue RuntimeError
      puts "Wagon type should be #{WAGON_TYPE.source}"
      puts 'Wagon type should not be nil!'
      raise 'Wagon type Error'
    end
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Type can't be nil!" if @type.nil?
    raise 'Type has invalid format' if @type !~ WAGON_TYPE
    true
  end
end