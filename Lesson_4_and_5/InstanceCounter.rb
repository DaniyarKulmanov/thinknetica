module InstanceCounter
  def self.included base
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessor :count

    def instances
      @count
    end
  end

  module InstanceMethods
    def register_instance
      self.class.count = 0 if self.class.count.nil?
      self.class.count += 1
    end
  end
end