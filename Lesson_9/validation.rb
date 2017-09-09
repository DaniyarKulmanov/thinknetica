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
      if @checks[variable].nil?
        check ||= {}
      else
        check = @checks[variable]
      end
      check[validation] ||= option
      @checks[variable] = check
    end
  end
  # Instance methods
  module InstanceMethods
    def validate!
      self.class.checks.each do |var, check|
        check.each do |validation, option|
          # TODO: change "send" to "instance_eval"
          raise "#{validation} error for #{var}" if send(validation, var, option)
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

    attr_writer :validations

    def presence(variable, option = nil)
      var = get_var variable
      var.nil? || var.to_s.strip.empty?
    end

    def format_check(variable, option)
      var = get_var variable
      option.class != Regexp || var !~ option
    end

    def class_type(variable, option)
      var = get_var variable
      var.class != option
    end

    def get_var(var)
      instance_variable_get "@#{var}"
    end
  end
end
