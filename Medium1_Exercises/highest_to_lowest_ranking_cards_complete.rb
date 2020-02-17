# Card class to store states and behaviors of the card objects to be compared
# Note: The @value instance variable stores the numerical value associated with the rank.
#  This is applicable for both face cards and numberical-based cards.

class Card
  attr_reader :rank, :suit, :value
  include Comparable

  def initialize(rank, suit)
    values = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
    @rank = rank
    @value = if values.keys.include?(rank)
              values[rank]
            else
              rank
            end
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other)
    self.value <=> other.value
  end
end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]

puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]

puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]

puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]

puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]

puts cards.min.rank == 8
puts cards.max.rank == 8
