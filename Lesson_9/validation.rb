# Module for all Validations in RailWays
module Validation
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end
  # Class methods
  module ClassMethods
    def validate(variable, validation, option = nil)
      case validation
      when :presence
        return false if variable.nil? || variable.to_s.strip.empty?
      when :format
        return false if option.class != Regexp || variable !~ option
      when :type
        return false unless variable.class == option
      else
        false
      end
      true
    end
  end
  # Instance methods
  module InstanceMethods
    def validate!(var, regx, type)
      raise 'Variable nil or empty' unless self.class.validate(var, :presence)
      raise 'Wrong format' unless self.class.validate(var, :format, regx)
      raise 'Class type not match' unless self.class.validate(var, :type, type)
      true
    end

    def valid?
      validate!
    rescue
      false
    end
  end
end
