# frozen_string_literal: true

# Class Something with both an instance method and a class method.
class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new # Assigns the string 'Hello' to @data
puts Something.dupdata # Prints 'ByeBye'
puts thing.dupdatax # Prints 'HelloHello'
