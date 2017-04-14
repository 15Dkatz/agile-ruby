require 'minitest'
require 'minitest/mock'
require 'minitest/autorun' # run 'ruby TripTest.rb' to run all tests
require './Trip' # load in the Trip classes

class TripTest < MiniTest::Test
  # setting up a mock to test the prepare method in Trip
  # def test_requests_trip_preparation
  #   @preparer = MiniTest::Mock.new
  #   @trip     = Trip.new
  #   @preparer.expect(:prepare_trip, nil, [@trip])
  #
  #   @trip.prepare([])
  #
  #   @preparer.verify
  # end
end

module PreparerInterfaceTest
  def test_implements_the_preparer_interface
    assert_respond_to(@object, :prepare_trip)
  end
end

class MechanicTest < MiniTest::Test
  include PreparerInterfaceTest

  def setup
    @mechanic = @object = Mechanic.new
  end
end

class DriverTest < MiniTest::Test
  include PreparerInterfaceTest

  def setup
    @driver = @object = Driver.new
  end
end

class TripCoordinatorTest < MiniTest::Test
  include PreparerInterfaceTest

  def setup
    @trip_coordinator = @object = TripCoordinator.new
  end
end
