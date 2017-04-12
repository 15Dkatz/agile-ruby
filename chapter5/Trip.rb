class Trip
  attr_reader :bicycles, :customers, :vhicle

  def prepare(preparers)
    preparers.each {|preparer|
      # prepare_trip is the method implemented through the duck type
      preparers.prepare_trip(self)}
  end
end

# Preparers are an interface and duck type

class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each{|bicycle|
      prepare_bicycle(bicycle)}
  end

  def prepare_bicycle(bicycle)
    puts bicycle
  end
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end

  def buy_food(customers)
    puts customers
  end
end
