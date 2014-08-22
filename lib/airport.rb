class Airport

  attr_accessor :hangar

  def initialize
    @hangar ||= []
    @airport_capacity ||= 3
  end

  def land(plane)
    raise "Airport full. Please try again later" if hangar.count >= 3
    @hangar << plane
  end

  def take_off(plane)
    @hangar.delete(plane)
  end
end
