# frozen_string_literal: true

MAX_SCORE = 21

# Group of methods to display the game-beginning and game-winning
# prompts.
module Messages
  def goodbye
    puts ''
    puts "Thank you for playing, #{player.name}!"
    sleep(1)
    puts 'Goodbye!'
  end

  def welcome
    puts 'Welcome to Twenty One!'
    puts '----------------------------------------------------'
    puts 'The goal of twenty-one is to reach a score higher'
    puts 'than the score of the dealer without going over 21'
    puts "If you go over 21, then you 'bust'."
    puts ''
    puts 'If the dealer busts, then you win.'
    puts 'If you bust, however, the dealer wins.'
    puts '----------------------------------------------------'
    sleep(5)
  end

  def display_scores
    puts "#{dealer.name} | #{dealer.points} Points"
    puts "#{player.name} | #{player.points} points"
  end

  def win_message(other)
    puts "#{other.name} busted!" if other.busted?
    puts "#{name} wins with #{points} points!"
  end

  def enter_to_continue
    puts 'Please press enter to continue...'
    loop do
      break if gets.chomp.empty?
    end
  end

  def initial_hand_prompt
    puts 'You must try to beat the dealers score.'
    enter_to_continue
    puts 'Your turn is about to begin. Afterwards, the '
    puts 'dealer will have a chance to hit or stay to '
    puts 'reach the highest possible score without going over 21.'
    sleep(2)
    puts 'Good Luck.'
    enter_to_continue
  end
end

# Groups of methods to orchestrate the rounds.
module Round
  def start_round
    @current_player = @player
    deal_initial_hands
    display_initial_hands
  end

  def execute_round
    loop do
      display_hand
      @current_player.turn(deck) unless @current_player.stayed
      break if @current_player.busted? || both_players_stayed

      alternate_player
    end
  end

  def deal_initial_hands
    @player.hand = @deck.draw_hand
    @dealer.hand = @deck.draw_hand
  end

  def display_hand
    @current_player.display_hand
    puts ''
  end

  def both_players_stayed
    @player.stayed && @dealer.stayed
  end

  private

  def display_initial_hands
    @player.display_hand
    @dealer.display_initial_hand
    sleep(5)
  end

  def alternate_player
    @current_player = @current_player == @player ? @dealer : @player
  end
end

# Behaviors common to both the player and the dealer
class Participant
  include Messages
  ACE = 11
  FACE_CARD = 10

  attr_reader :name
  attr_accessor :hand, :stayed

  def initialize
    @name = set_name
    @hand = []
    @stayed = false
  end

  def <(other)
    points < other.points
  end

  def points
    calculate_total
  end

  def hit(deck)
    puts "#{name} has decided to hit"
    sleep(1)

    hand << deck.draw_card
    display_hand
  end

  def stay
    puts "#{name} has decided to stay."
    sleep(1)
    self.stayed = true
  end

  def to_s
    hand.map { |card| "#{card.value} of #{card.suit}" }.join(', ')
  end

  def display_hand
    system 'clear'
    puts "#{name}'s Hand:"
    puts ''
    puts '-----------------'
    hand.each do |card|
      puts "->  #{card}"
    end
    puts '-----------------'
    puts "#{points} Points"
  end

  def reset_hand
    @hand = []
    @stayed = false
  end

  def busted?
    points > MAX_SCORE
  end

  private

  # rubocop:disable Metrics/MethodLength
  def calculate_total
    total = 0
    hand.each do |card|
      total += if card.kqj
                 FACE_CARD
               elsif card.ace?
                 ACE
               else
                 card.value
               end
    end
    hand.count(&:ace?).times { total -= 10 if total > 21 }
    total
  end
  # rubocop:enable Metrics/MethodLength
end

# Behaviors/States specific to the player
class Player < Participant
  def set_name
    answer = nil
    puts 'Lets start with your name.'
    puts 'Please enter your name below:'

    loop do
      answer = gets.chomp.strip.capitalize
      break if valid_name?(answer)

      puts 'That is an invalid name. Please try again.'
    end

    answer
  end

  def turn(deck)
    loop do
      break if busted? || stayed

      puts 'Would you like to hit (h) or stay (s)?'
      if turn_input == 'h'
        hit(deck)
      else
        stay
      end
    end
  end

  private

  def turn_input
    answer = nil
    loop do
      answer = gets.chomp.strip.downcase
      break if %w(h s).include?(answer)

      puts 'That is an invalid input. Please try again.'
    end
    answer
  end

  def valid_name?(name)
    name.size > 2
  end
end

# Behaviors for the dealer
class Dealer < Participant
  DEALER_MAX = 17

  def set_name
    %w[Fred Greg Carly HotShot Dave].sample
  end

  def turn(deck)
    loop do
      break if busted? || stayed

      puts "#{name} is thinking..."
      sleep(2)
      if points < DEALER_MAX
        hit(deck)
      else
        stay
      end
    end
  end

  def display_initial_hand
    system 'clear'
    puts 'Dealers Hand:'
    puts '------------'
    puts "-> #{hand.first}"
    puts '-> ???'
    puts ''
    initial_hand_prompt
  end
end

# Behaviors of the cards stored in the deck
class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def ace?
    value == 'Ace'
  end

  def kqj
    king? || queen? || jack?
  end

  def to_s
    "#{value} of #{suit}"
  end

  private

  def king?
    value == 'King'
  end

  def queen?
    value == 'Queen'
  end

  def jack?
    value == 'Jack'
  end
end

# Behaviors/Attributes of the deck of cards
class Deck
  SUITS = %w[Spades Diamonds Clovers Clubs].freeze
  VALUES = %w[Jack Queen King Ace].freeze

  def initialize
    @cards = []
    SUITS.each do |suit|
      VALUES.each { |value| cards << Card.new(value, suit) }
      (2..10).each { |value| cards << Card.new(value, suit) }
    end
  end

  def draw_card
    drawn_card = cards.sample
    cards.delete(drawn_card)
    drawn_card
  end

  def draw_hand
    hand = []

    2.times do
      draw = cards.sample
      @cards.delete(draw)
      hand << draw_card
    end

    hand
  end

  private

  attr_reader :cards
end

# Orchestrator for all elements
class Game
  include Round
  include Messages

  def start_game
    system 'clear'
    welcome
    set_game_objects
    clear
    start_round
  end

  def play
    start_game
    loop do
      execute_round
      display_hand
      display_scores
      display_result
      break unless play_again?

      reset_game
    end
    goodbye
  end

  private

  def play_again?
    puts 'Would you like to play again? (y/n)'
    answer = nil

    loop do
      answer = gets.chomp.strip.downcase
      break if %w[y n].include?(answer)

      puts 'That is an invalid answer. Please try again.'
    end

    answer == 'y'
  end

  def set_game_objects
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def reset_game
    puts 'Resetting Game...'
    sleep(3)

    @deck = Deck.new
    @player.reset_hand
    @dealer.reset_hand

    puts 'Success...'
    sleep(1)
    start_round
  end

  def display_result
    puts ''
    case detect_winner
    when 'Player'
      player.win_message(dealer)
    when 'Dealer'
      dealer.win_message(player)
    else
      puts 'Its a tie!'
    end
  end

  def detect_winner
    # Check if a player busted first, we want to declare a winner right when
    # a participant busts, regardless of the points the busted participant has
    if player.busted?
      'Dealer'
    elsif dealer.busted?
      'Player'
    elsif dealer < player
      'Player'
    elsif player < dealer
      'Dealer'
    end
  end

  def clear
    system 'clear'
  end
  attr_reader :deck, :player, :dealer
end

Game.new.play
