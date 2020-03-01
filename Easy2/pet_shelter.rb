# frozen_string_literal: true

# Template to specify the name and type of pet.
class Pet
  attr_reader :name, :type

  def initialize(type, name)
    @name = name
    @type = type
  end
end

# Template for the owner. Shelter will draw most data from owner,
# and get pet info from pets, through
# the association of pet objects from Owner.
class Owner
  attr_reader :name
  attr_accessor :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    @pets.size
  end
end

# Shelter is the orchestrator for this program.
class Shelter
  def initialize
    @owners = []
  end

  def adopt(owner, pet)
    owners << owner unless owners.include?(owner)
    owner.pets << pet
  end

  def print_adoptions
    @owners.uniq do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.pets.each { |pet| puts "A #{pet.type} named #{pet.name}" }
      space
    end
  end

  private

  attr_accessor :owners

  def space
    puts ''
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.
