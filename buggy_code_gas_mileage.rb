class Car
  attr_writer :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = @mileage + miles
    self.mileage = total
  end

  def print_mileage
    puts mileage
  end

  private

  attr_reader :mileage
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678
# Currently prints 5000

# Change Implemented:
# Added the self caller on line 10. Creating a writer method,
# rather than local variable initialization that was previously implemented.
