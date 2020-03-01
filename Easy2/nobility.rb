# frozen_string_literal: true

# Module to mix in the walk method. For any class that needs walking
# functionality.
module Walkable
  def walk
    "#{title} #{name} #{gait} forward."
  end
end

# Template for Person object to store name and gait.
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

# Template for Cat object to store name state.
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

# Template for Cheetah object to store name and gait.
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

# Template for Noble object to store name, title, and gait.
class Noble
  attr_reader :name, :title
  include Walkable

  def initialize(name, title)
    @name = name
    @title = title
  end

  private

  def gait
    'struts'
  end
end

byron = Noble.new('Byron', 'Lord')

p byron.walk
p byron.name
p byron.title
