require_relative 'produce_company'
require_relative 'instance_counter'
# Wagon class
class Wagon
  include ProduceCompany
  include InstanceCounter

  WAGON_TYPE = /Passenger|Cargo/

  attr_accessor :type

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
