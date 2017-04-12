=begin
class Bicycle
  attr_reader :size, :tape_color

  def initialize(args)
    @size       = args[:size]
    @tape_color = args[:tape_color]
  end

  def spares
    { chain:      '10-speed',
      tire_size:  '23',
      tape_color: tape_color }
  end
end

bike = Bicycle.new(
  size:       'M',
  tape_color: 'red'
)

puts bike.size
puts bike.tape_color
=end

class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size      = args[:size]
    @chain     = args[:chain]     || default_chain
    @tire_size = args[:tire_size] || default_tire_size

    post_initialize(args)
  end

  def post_initialize(args)
    nil
  end

  def spares
    { tire_size: tire_size,
      chain:     chain }.merge(local_spares)
  end

  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError,
      "This #{self.class} cannot respond to:"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  # def initialize(args)
  #   @tape_color = args[:tape_color]
  #   super(args) #RoadBike's initiailize MUST send 'super' because it's a subclass of Bicycle
  # end

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def local_spares
    {tape_color: tape_color}
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  # def initialize(args)
  #   @front_shock = args[:front_shock]
  #   @rear_shock  = args[:rear_shock]
  #   super(args)
  # end
  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock  = args[:rear_shock]
  end

  def local_spares
    { rear_shock: rear_shock }
  end

  def default_tire_size
    '2.1'
  end
end

@red_bike = MountainBike.new(
  :size        => 'L',
  :chain       => 'titanium',
  :rear_shock  => 'strong',
  :front_shock => 'vigorous'
)

puts @red_bike.size
puts @red_bike.default_tire_size
puts @red_bike.front_shock
