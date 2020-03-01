class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def rename(new_name)
    self.name = new_name
  end
  
  private
 
  attr_writer :name
end

kitty = Cat.new('Sophie')
kitty.name
kitty.rename('Chloe')
kitty.name
