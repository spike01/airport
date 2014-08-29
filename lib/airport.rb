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
    raise "This plane has already landed!" if plane.flight_status == :landed
    return "Airport full. Please try again later" if hangar.count >= capacity 
    return "Bad weather. Please try again later" if weather == :stormy
    hangar << plane
    plane.flight_status= :landed
  end

  def take_off(plane)
    raise "This plane is already in the air!" if plane.flight_status == :flying
    return "Bad weather. Please try again later" if weather == :stormy
    hangar.delete(plane).flight_status = :flying
  end

  def land_all_planes(planes)
    return if planes.empty?
    planes.each do |plane| 
      land(plane)    
      planes.delete(plane) if plane.flight_status == :landed
    end
    land_all_planes(planes)
  end

  def fly_all_planes
    return if hangar.empty?
    hangar.each { |plane| take_off(plane) }
    fly_all_planes
  end
end
