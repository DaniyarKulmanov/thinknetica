module InstanceCounter
  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessor :count

    def count_initialize
      @count = 0
    end

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