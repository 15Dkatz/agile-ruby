
class Gear
  attr_reader :chainring, :cog, :wheel, :observer

  # note the initialize field with fixed-order arguments
  def initialize(args)
    @chainring = args[:chainring]
    @cog       = args[:cog]
    @wheel     = args[:wheel]
    @observer  = args[:observer]
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

  def set_cog(new_cog)
    @cog = new_cog
    changed
  end

  def set_chainring(new_chainring)
    @chainring = new_chainring
    changed
  end

  def changed
    observer.changed(chainring, cog)
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

# gear = GearWrapper.gear(
#     :chainring => 52,
#     :cog       => 11,
#     :wheel     => Wheel.new(26, 1.5))

# puts gear.diameter
