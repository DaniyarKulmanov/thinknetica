module InstanceCounter
  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
    base.singleton_class.send(:attr_accessor, :count)
  end

  module ClassMethods
    def instances
      @count
    end
  end

  module InstanceMethods
    def register_instance
      self.class.count += 1
    end
  end

end