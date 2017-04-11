module GearFramework
  class Gear
    attr_reader :chainring, :cog, :wheel

    # note the initialize field with fixed-order arguments
    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog       = cog
      @wheel     = wheel
    end

    def ratio
      chainring / cog.to_f
    end

    def gear_inches
      # wheel is a variable representing any object - Wheel, Disc, Cylinder, etc.
      # dependency injection
      ratio * diameter
    end

    def diameter
      wheel.diameter
    end
  end
end

# notice the use of a specific module as a factory to generate Gear objects
module GearWrapper
  def self.gear(args)
    GearFramework::Gear.new(args[:chainring],
                            args[:cog],
                            args[:wheel])
  end
end



class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim  = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end

  def circumfrence
    diameter * Math::PI
  end
end

puts GearWrapper.gear(
    :chainring => 52,
    :cog       => 11,
    :wheel     => Wheel.new(26, 1.5)).gear_inches
