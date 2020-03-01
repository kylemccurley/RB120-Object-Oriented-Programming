module Walkable
  def walk
    "#{title} #{name} #{gait} forward."
  end
end

class Person
  attr_reader :name
  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name
  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name
  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

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

byron = Noble.new("Byron", "Lord")

p byron.walk
p byron.name
p byron.title