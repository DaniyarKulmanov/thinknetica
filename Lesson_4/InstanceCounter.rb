module InstanceCounter
  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    @@count = 0
    attr_reader :count

    def instances
      @@count
    end

    def count
      @@count += 1
    end
  end

  module InstanceMethods
    @@count_instance = 0
    def count_instance
      puts @@count_instance
    end

    def register_instance
      @@count_instance += 1
    end
    private :register_instance
  end
end