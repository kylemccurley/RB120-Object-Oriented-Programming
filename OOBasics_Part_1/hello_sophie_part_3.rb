class Cat
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
