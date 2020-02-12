class GuessingGame
  def initialize(low_value, high_value)
    @guess = nil
    @remaining_guesses = Math.log2(high_value - low_value).to_i + 1
    @range = (low_value...high_value)
    @correct_answer = @range.to_a.sample
  end

  def play
    display_welcome_message
    loop do
      display_remaining_guesses
      player_input
      display_guess_result
      update_guesses
      break if (player_won? || out_of_guesses)
    end
    display_game_result
  end

  private

  def update_guesses
    @remaining_guesses -= 1
  end

  def display_welcome_message
    puts '+-------------------------------+'
    puts '| Welcome to the Guessing Game! |'
    puts '+-------------------------------+'
  end

  def display_remaining_guesses
    if @remaining_guesses == 1
      puts "You have #{@remaining_guesses} guess left"
    else
      puts "You have #{@remaining_guesses} guesses left"
    end
  end

  def display_guess_result
    puts case guess_check
         when :high then 'Guess is too high'
         when :low then 'Guess is too low'
         when :correct then 'Correct!'
         end
  end

  def display_game_result
    system 'clear'
    sleep(1)
    if player_won?
      20.times { puts 'Congrats! You won the game!' }
    elsif out_of_guesses
      puts 'Sorry. You are out of guesses'
      puts 'and have lost the game.'
    end
  end

  def player_input
    prompt_user
    loop do
      self.guess = gets.chomp.to_i
      break if valid_input

      puts 'Invalid Input. Please try again.'
    end
  end

  def prompt_user
    puts "Please enter a number between #{@range.first} and #{@range.last}."
  end

  def player_won?
    guess_check == :correct
  end

  def guess_check
    if @guess > @correct_answer
      :high
    elsif @guess < @correct_answer
      :low
    else
      :correct
    end
  end

  def out_of_guesses
    @remaining_guesses == 0
  end

  def valid_input
    @range.cover?(guess)
  end

  attr_accessor :guess
  attr_reader :correct_answer
end

GuessingGame.new(501, 1000).play
