# Update the following code so that it prints I'm Sophie! when it invokes puts kitty.

class Cat
  def initialize(name)
    @name = name
  end
  
  def to_s
    "I'm #{name}!"
  end
  
  private
  
  attr_reader :name
end

kitty = Cat.new('Sophie')
puts kitty
