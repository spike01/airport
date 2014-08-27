require 'airport'
require 'plane'
require 'weather'

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport and how that is impermented.
#
# If the airport is full then no planes can land
describe Airport do

  #include Weather

  let(:airport) { Airport.new }
  let(:plane) { double :plane }

  context 'taking off and landing' do
    it 'a plane can land' do
      allow(airport).to receive(:weather).and_return(:sunny)
      allow(plane).to receive(:flight_status=)
      airport.land(plane)
      expect(airport.hangar.count).to eq(1)
    end
    
    it 'a plane can take off' do
      allow(airport).to receive(:weather).and_return(:sunny)
      allow(plane).to receive(:flight_status=)
      airport.land(plane)
      airport.take_off(plane)
      expect(airport.hangar.count).to eq(0)
    end
    
  end
  
  context 'capacity' do
    it 'initializes empty' do
      expect(airport.hangar.count).to eq(0)
    end

    it 'initializes with a default capacity' do
      expect(airport.capacity).to eq(10)
    end

    it 'can be initialized with a custom capacity' do
      expect((Airport.new(capacity: 6)).capacity).to eq(6)
    end

  context 'traffic control' do
    it 'a plane cannot land if the airport is full' do
      allow(airport).to receive(:weather).and_return(:sunny)
      (airport.capacity).times { airport.land(Plane.new) }
      expect(airport.land(plane)).to eq("Airport full. Please try again later")
    end 
  end
    # Include a weather condition using a module.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
    # 
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport
    
    context 'weather conditions' do
      it 'a plane cannot take off when there is a storm brewing' do
        allow(airport).to receive(:weather).and_return(:stormy)
        expect(airport.take_off(plane)).to eq("Bad weather. Please try again later")
      end
      
      it 'a plane cannot land in the middle of a storm' do
        allow(airport).to receive(:weather).and_return(:stormy)
        expect(airport.land(plane)).to eq("Bad weather. Please try again later")
      end
    end
  end
end

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"
describe Plane do

  let(:plane) { Plane.new }
  let(:airport) { Airport.new }

  it 'has a flying status when created' do
    expect((Plane.new).flight_status).to eq(:flying)
  end
  
  it 'has a flying status when in the air' do
   expect(plane.flight_status).to eq(:flying) 
  end
  
  it 'can take off' do
    allow(airport).to receive(:weather).and_return(:sunny)
    airport.land(plane)
    expect(plane.flight_status).to eq(:landed)
    airport.take_off(plane)
    expect(plane.flight_status).to eq(:flying)
  end
  
  it 'changes its status to flying after taking off' do
    allow(airport).to receive(:weather).and_return(:sunny)
    airport.land(plane)
    airport.take_off(plane)
    expect(plane.flight_status).to eq(:flying)
  end
end

# grand finale
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!

describe "The grand finale (last spec)" do

  let(:airport) { Airport.new }
  let(:sky) { [] }

  def make_planes
    6.times { sky << Plane.new }
  end

  it 'the airport can land all planes in the sky, in good weather' do
    allow(airport).to receive(:weather).and_return(:sunny) 
    make_planes
    airport.land_all_planes(sky)
    expect(airport.hangar.count).to eq(6)
    expect(sky.count).to eq(0)
  end

  it 'the airport can have all planes take off, in good weather' do
    allow(airport).to receive(:weather).and_return(:sunny)
    make_planes
    airport.fly_all_planes
    expect(airport.hangar.count).to eq(0)
  end

  it 'the airport can land all planes in the sky' do
    make_planes
    airport.land_all_planes(sky)
    expect(airport.hangar.count).to eq(6)
  end
                                                                     
                                                                     #def land_planes
    #until red_arrows.empty? do
      #red_arrows.each { |plane| airport.land(plane) }
    #end
  #end

  xit 'all planes can land and all planes can take off' do
    make_planes
    land_planes
    expect(airport.hangar.map { |plane| plane.flight_status }).to eq([:landed, :landed, :landed, :landed, :landed, :landed])
    fly_planes
    expect(red_arrows.map { |plane| plane.flight_status }).to eq([:flying, :flying, :flying, :flying, :flying, :flying])
  end
end
