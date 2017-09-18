# Module for all Validations in RailWays
module Validation
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end
  # Class methods
  module ClassMethods
    attr_reader :validations

    def validate(attribute, validation, option = nil)
      @validations ||= {}
      @validations[attribute] ||= []
      @validations[attribute] << { validation: validation, option: option }
    end
  end
  # Instance methods
  module InstanceMethods
    def validate!
      self.class.validations.each do |attr_name, attr_rules|
        attr_value = instance_variable_get("@#{attr_name}")
        attr_rules.each do |rule|
          send("validate_#{rule[:validation]}", attr_value, rule[:option])
        end
      end
    end

    def valid?
      validate!
    rescue
      false
    end

    private

    def validate_presence(value, option = nil)
      raise 'Field empty value or nil' if value.nil? || value.to_s.strip.empty?
    end

    def validate_format(value, option)
      raise 'Incorrect format' if option.class != Regexp || value !~ option
    end

    def validate_type(value, option)
      raise 'Incorrect type' if value.class != option
    end
  end
end
