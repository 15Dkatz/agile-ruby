# bad example, with direct references to complicated data structures
class ObscuringReferences
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def diameters
    data.collect {|cell|
      cell[0] + (cell[1] * 2)}
  end
end

arr1 = ObscuringReferences.new([[622, 20], [622, 23]])
puts arr1.diameters

# better example, that changes in only one place if the input changes
class RevealingReference
  attr_reader :wheels
  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect {|wheel|
      wheel.rim + (wheel.tire * 2)}
  end

  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect {|cell|
      Wheel.new(cell[0], cell[1])}
  end
end

arr2 = RevealingReference.new([[622, 20], [622, 23]])
puts arr2.wheels
puts arr2.diameters
