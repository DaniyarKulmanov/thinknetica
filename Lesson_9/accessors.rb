# Accessors module
module Accessors
  module ClassMethods
    def attr_accessor_with_history(*attributes)
      attributes.each do |attribute|
        define_method "#{attribute}_history" do
          instance_variable_get("@#{attribute}_history") || []
        end
        define_method(attribute) do
          instance_variable_get("@#{attribute}") || instance_variable_set("@#{attribute}", options[:default])
        end
        define_method("#{attribute}=") do |value|
          history = send("#{attribute}_history")
          instance_variable_set("@#{attribute}", value)
          instance_variable_set("@#{attribute}_history", history)
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
          raise TypeError, message unless v.is_a? options[:class]
          instance_variable_set("@#{method}", v)
        end
      end
    end
  end
end
