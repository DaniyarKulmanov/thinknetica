# Module for all Validations in RailWays
module Validation
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end
  # Class methods
  module ClassMethods
    attr_reader :checks

    def validate(variable, validation, option = nil)
      @checks ||= {}
      @checks[variable] ||= []
      @checks[variable] << { validation: validation, option: option }
    end
  end
  # Instance methods
  module InstanceMethods
    def validate!
      self.class.checks.each do |var, validations|
        var = get_var(var)
        validations.each do |validation|
          # TODO: change "send" to "instance_eval"
          send(validation[:validation], var, validation[:option])
        end
      end
      true
    end

    def valid?
      validate!
    rescue
      false
    end

    private

    def presence(value, option = nil)
      raise 'Field empty value or nil' if value.nil? || value.to_s.strip.empty?
    end

    def format(value, option)
      raise 'Incorrect format' if option.class != Regexp || value !~ option
    end

    def validate_type(value, option)
      raise 'Incorrect type' if value.class != option
    end

    def get_var(var)
      instance_variable_get "@#{var}"
    end
  end
end
