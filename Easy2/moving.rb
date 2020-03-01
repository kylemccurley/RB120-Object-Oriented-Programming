# frozen_string_literal: true

# Module for Walkable to add walking functionality.
module Walkable
  def walk
    puts "#{name} #{gait} forward."
  end
end

# Template for all object of Person
class Person
  attr_reader :name
  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    'strolls'
  end
end

# Class to hold the states/behaviors of Cat objects.
class Cat
  attr_reader :name
  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    'saunters'
  end
end

# Class to hold the states/behaviors of Cheetah objects.
class Cheetah
  attr_reader :name
  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    'runs'
  end
end

# Code Modified to make the below code work.

mike = Person.new('Mike')
mike.walk # Mike strolls forward

kitty = Cat.new('Kitty')
kitty.walk # Kitty saunters forward

flash = Cheetah.new('Flash')
flash.walk # => Flash runs forward
