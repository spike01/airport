class Airport

  DEFAULT_CAPACITY = 3

  attr_accessor :hangar
  attr_reader :capacity

  def initialize
    @hangar ||= []
    @capacity ||= DEFAULT_CAPACITY 
  end

  def land(plane)
    raise "Airport full. Please try again later" if hangar.count >= capacity 
    @hangar << plane
  end

  def take_off(plane)
    @hangar.delete(plane)
  end
end
