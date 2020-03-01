=begin
Using the code from the previous exercise, add a setter method named #name.
Then, rename kitty to 'Luna' and invoke #greet again
=end

class Cat
  attr_writer :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
  
  private
  
  attr_reader :name
end

kitty = Cat.new('Sophie')
kitty.greet

kitty.name = 'Luna'
kitty.greet

=begin
  Expected Output:
  
  Hello! My name is Sophie!
  Hello! My name is Luna!
=end
