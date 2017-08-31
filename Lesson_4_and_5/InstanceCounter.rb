module InstanceCounter
  def self.included base
    base.include InstanceMethods
    base.extend ClassMethods
    base.instances = 0
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    def register_instance
      self.class.instances += 1
    end
  end

end