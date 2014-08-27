require './lib/weather'

class Airport

  include Weather

  DEFAULT_CAPACITY = 10

  attr_accessor :hangar, :capacity

  def initialize(options = {})
    self.capacity = options.fetch(:capacity, capacity)
    @hangar ||= []
    @capacity ||= DEFAULT_CAPACITY 
  end

  def land(plane)
    return "Airport full. Please try again later" if hangar.count >= capacity 
    return "Bad weather. Please try again later" if weather == :stormy
    @hangar << plane
    plane.flight_status= :landed
  end

  def take_off(plane)
    return "Bad weather. Please try again later" if weather == :stormy
    @hangar.delete(plane)
    plane.flight_status= :flying
  end

  def land_all_planes(planes)
    planes.each { |plane| land(plane); planes.shift }
  end

end
