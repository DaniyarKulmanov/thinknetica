# Accessors module
module Accessors
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  # class methods
  module ClassMethods
    def attr_accessor_with_history(*methods)
      options = methods.last.is_a?(Hash) ? methods.pop : {}
      methods.each do |method|
        method.to_sym unless method.is_a? Symbol
        define_method "#{method}_history" do
          instance_variable_get("@#{method}_history") || [nil]
        end
        define_method(method) do
          instance_variable_get("@#{method}") || instance_variable_set("@#{method}", options[:default])
        end
        define_method("#{method}=") do |v|
          value = instance_variable_get("@#{method}_history")
          value ||= [nil]
          value << v
          instance_variable_set("@#{method}", v)
          instance_variable_set("@#{method}_history", value)
        end
      end
    end

    def strong_attr_accessor(*methods)
      options = methods.last.is_a?(Hash) ? methods.pop : {}
      methods.each do |method|
        method.to_sym unless method.is_a? Symbol
        define_method(method) do
          instance_variable_get("@#{method}") || instance_variable_set("@#{method}", options[:default])
        end
        define_method("#{method}=") do |v|
          message = "input value class must be #{options[:class]} "
          raise TypeError.new, message if v.class.to_s != options[:class].to_s
          instance_variable_set("@#{method}", v)
        end
      end
    end
  end

  # instance methods
  module InstanceMethods
    # ...
    # attribute_history
    # strong_attr_accessor
  end
end
