# class Gear
#   attr_reader :chainring, :cog, :rim, :tire
#   def initialize(chainring, cog, wheel=nil)
#     @chainring = chainring
#     @cog       = cog
#     @rim       = rim
#     @tire      = tire
#   end
#
#   def ratio
#     chainring / cog.to_f
#   end
#
#   def gear_inches
#     # bad code - creates a depency on the Wheel class
#     # this prevents interaction with other objects that potentially have a diameter, like Disc, or Cylinder.
#     ratio * Wheel.new(rim, tire).diameter
#   end
# end

class Gear
  attr_reader :chainring, :cog, :wheel
  # OPTION ONE for initializing with defaults
  # def initialize(args)
  #   @chainring = args.fetch(:chainring, 40)
  #   @cog       = args.fetch(:cog, 18)
  #   @wheel     = args[:wheel]
  # end

  #OPTION TWO for initializing with defaults
  def initialize(args)
    args = defaults.merge(args)
    @chainring = args[:chainring]
    @cog       = args[:cog]
    @wheel     = args[:wheel]
  end

  def defaults
    {:chainring => 40, :cog => 10}
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

class Wheel
  attr_reader :rim, :tire

  def initialize(args)
    @rim  = args[:rim]
    @tire = args[:tire]
  end

  def diameter
    rim + (tire * 2)
  end

  def circumfrence
    diameter * Math::PI
  end
end

# Gear expects a 'Duck' that knows 'diameter'
puts Gear.new(
  :chainring => 52,
  :cog      => 11,
  :wheel    => Wheel.new(
                :rim => 26,
                :tire => 1.5)).gear_inches

@gear = Gear.new(:wheel => Wheel.new(:rim => 26, :tire => 1.5))
puts @gear.gear_inches
