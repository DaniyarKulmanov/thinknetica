module InstanceCounter
  @@count = 0
  attr_reader :count

  def count
    @@count += 1
  end

  def instances
    @@count
  end
end