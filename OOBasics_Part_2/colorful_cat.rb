=begin
Using the following code, create a class named Cat that prints a greeting when #greet is invoked. 
The greeting should include the name and color of the cat. Use a constant to define the color.
=end

class Cat
  COLORS = %w(red green blue yellow)

  def initialize(name)
    @name = name
  end
  
  def greet; puts "Hello! My name is #{name} and I am a #{COLORS.sample} cat!"; end
  
  private
  
  attr_reader :name
end

kitty = Cat.new('Sophie')
puts kitty.greet
