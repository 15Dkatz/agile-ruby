module Schedulable
  attr_writer :schedule #attr_writer?

  def schedule
    @schedule ||= ::Schedule.new
  end

  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  def lead_days
    0
  end
end

class Schedule
  def scheduled?(schedulable, start_date, end_date)
    puts "This #{schedulable.class} " +
         "is not scheduled\n" +
         "  between #{start_date} and #{end_date}"
    false # always returns false for now
  end
end

class Bicycle
  include Schedulable

  attr_reader :size, :parts

  def initialize(args={})
    @size      = args[:size]
    @parts     = args[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :parts

  def initialize(input)
    @parts = input
  end

  def spares
    parts.select{ |part| part.needs_spare }
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name        = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end

class RoadBikeParts < Parts
  attr_reader :tape_color

  # implicitly calls the initialize of the Bicycle superclass
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


class MountainBikeParts < Parts
  attr_reader :front_shock, :rear_shock

  # implicitly calls the initialize of the Bicycle superclass
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
# TESTING / SCRATCH:

# chain = Part.new(name: 'chain', description: '10-speed')
# road_tire = Part.new(name: 'tire_dize', description: '23')
# tape = Part.new(name: 'tape_color', description: 'red')
#
# road_bike = Bicycle.new(
#   size: 'L',
#   parts: Parts.new([chain, road_tire, tape])
# )

# puts tape.needs_spare

# puts road_bike.spares


# road_bike = Bicycle.new(
#   size: 'L',
#   parts: RoadBikeParts.new(tape_color: 'red')
# )
#
# puts road_bike.spares
#
# mountain_bike = Bicycle.new(
#   size: 'L',
#   parts: MountainBikeParts.new(rear_shock: 'Strong')
# )
#
# puts mountain_bike.spares
