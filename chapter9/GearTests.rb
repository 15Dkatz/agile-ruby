require 'minitest'
require './GearModule'

class GearTestOne < MiniTest::Test
  def test_calculates_gear_inches
    gear = GearWrapper.gear(
      chainring: 52,
      cog:       11,
      wheel:     Wheel.new(26, 1.5)
    )

    assert_in_delta(137.1,
                    gear.gear_inches,
                    0.01)
  end
end

# a_test = GearTest.new('a')
# puts a_test.test_calculates_gear_inches


#testing with a double...

class DiameterDouble
  def diameter
    10
  end
end

class GearTestTwo < MiniTest::Test
  def test_calculates_gear_inches
    gear = GearWrapper.gear(
      chainring: 52,
      cog:       11,
      wheel:     DiameterDouble.new)

    assert_in_delta(47.27,
                    gear.gear_inches,
                    0.01)
  end
end

# b_test = GearTestTwo.new('test')
# puts b_test.test_calculates_gear_inches

# testing whether the Wheel class plays the diameterizable role
class WheelTest < MiniTest::Test
  def setup
    @wheel = Wheel.new(26, 1.5)
  end

  def test_implements_the_diamterizable_interface
    assert_respond_to(@wheel, :diameter)
  end

  def test_calculates_diameter
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(
      29,
      wheel.diameter, 0.01)
  end
end


c_test = WheelTest.new('test')
puts c_test.test_implements_the_diamterizable_interface
