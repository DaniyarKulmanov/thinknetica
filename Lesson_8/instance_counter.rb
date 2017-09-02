# Instances counter for classes
module InstanceCounter
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end
  # class-methods
  module ClassMethods
    attr_accessor :count

    def instances
      @count
    end
  end
  # instance-methods
  module InstanceMethods
    def register_instance
      self.class.count = 0 if self.class.count.nil?
      self.class.count += 1
    end
  end
end
