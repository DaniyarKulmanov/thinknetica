# Accessors module
module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  # class methods
  module ClassMethods
    def attr_accessor_with_history(*methods)
      options = methods.last.is_a?(Hash) ? methods.pop : {}
      methods.each do |method|
        define_method "#{method}_history" do
          instance_variable_get("@#{method}_history") || []
        end
        define_method(method) do
          instance_variable_get("@#{method}") || instance_variable_set("@#{method}", options[:default])
        end
        define_method("#{method}=") do |v|
          value = instance_variable_get("@#{method}_history")
          value ||= []
          value << v
          instance_variable_set("@#{method}", v)
          instance_variable_set("@#{method}_history", value)
        end
      end
    end

    def strong_attr_accessor(*methods)
      options = methods.last.is_a?(Hash) ? methods.pop : {}
      methods.each do |method|
        define_method(method) do
          instance_variable_get("@#{method}") || instance_variable_set("@#{method}", options[:default])
        end
        define_method("#{method}=") do |v|
          message = "input value class must be #{options[:class]} "
          raise TypeError.new, message unless v.is_a? options[:class]
          instance_variable_set("@#{method}", v)
        end
      end
    end
  end
end
