class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # This will output 'Fluffy'
puts fluffy      # Puts calls to_s on fluffy, this is the Pet#to_s method.  'My name is FLUFFY'
                 # The upcase method mutates the strings referenced by the local/instance variables.
puts fluffy.name # 'FLUFFY'
puts name        # 'FLUFFY'


# Extra Bonus:

name = 42
fluffy = Pet.new(name)
name += 1  # Reassigns the local variable name to the integer 43.
puts fluffy.name  # Outputs the string '42'
puts fluffy       # Outputs "My name is 42". Output of the Pet#to_s method
puts fluffy.name  # Outputs '42'. '42' being the instance variable @name
puts name         # Outputs 43. Reference to name local variable on line 24

=begin
Why does lines 22 to 28 work?
  On line 23, the name local variable referencing the integer 42 is passed into
the initialize method. when this happens, an instance variable is created with the @name instance variable
assigned to the integer 42 with Kernel#to_s called on it, making 42 a string referenced by @name.
At this point the local variable name still references the integer 42 that was initialized on line 22.

  On line 24, the += method is called on name, the local variable 42, which reassigns name to 43. It is important to note that
at this point, the name local variable is still pointing an integer 42, whereas @name is pointing to the string 42.
@name and name are now pointing to completely separate objects, and have no relation to
each other.

  On line 25, the instance variable name is called for the object fluffy,
with puts calling to_s on the instance variable.
This instance variable for name still references
the string 42, which is what is output on line 26.

  On line number 26, puts calls the to_s method on the
fluffy object, executing the line that
outputs 'My name is 42'. 42 being the output of the reference
to the name instance variable.
=end
