require_relative 'produce_company'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'
# Wagon class
class Wagon
  include ProduceCompany
  include InstanceCounter
  include Accessors
  include Validation

  WAGON_TYPE = /Passenger|Cargo/

  attr_accessor :type

  validate :type, :presence
  validate :type, :format, Wagon::WAGON_TYPE
  validate :type, :type, String

  def initialize(type)
    @type = type
    register_instance
  end
end
