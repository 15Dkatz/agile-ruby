class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size      = args[:size]
    @parts     = args[:parts]
  end

  def spares
    parts.spares
  end
end

require 'forwardable'
class Parts
  extend Forwardable # this will allow delegation of methods to another class
  def_delegators  :@parts, :size, :each
  include Enumerable # includes the Enumberable module which does common traversal and searching methods

  attr_reader :parts

  def initialize(input)
    @parts = input
  end

  def spares
    parts.select{ |part| part.needs_spare }
  end
end

# The parts factory now understands config's internal structure
# In this way, composed bicycles in a config can be specified as an array rather than a hash

require 'ostruct'
module PartsFactory
  def self.build(config, parts_class = Parts)

    parts_class.new(
      config.collect{|part_config|
        create_part(part_config)})
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name:        part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true)
    )
  end
end

# TESTING / SCRATCH:
road_config =
  [['chain',      '10-speed'],
   ['tire_size',  '23'],
   ['tape_color', 'red']]

road_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(road_config)
  )

puts road_bike.spares


recumbent_config =
  [['chain',     '9-speed'],
   ['tire_size', '28'],
   ['flag',      'tall and orange']]

recumbent_bike =
  Bicycle.new(
    size: 'L',
    parts: PartsFactory.build(recumbent_config)
  )

puts "\n"
puts recumbent_bike.spares
