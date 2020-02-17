class Card
  attr_reader :rank, :suit

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end
end

class Deck
  attr_reader :cards
  SUITS = %w(Hearts Spades Clovers Diamonds)

  def initialize
    @cards = []
    SUITS.each do |suit|
      ((2..10).to_a + %w(Jack Queen Kings Ace)).each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
    @cards.shuffle!
  end

  def draw
    @cards.pop
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
